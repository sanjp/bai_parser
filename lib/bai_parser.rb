require "bai_parser/version"

module BaiParser
  
  class Parser
    
    RECORD_CODES = {'01' => :file_header,
                    '02' => :group_header,
                    '03' => :account_identifier,
                    '16' => :transaction_detail,
                    '49' => :account_trailer,
                    '88' => :continuation,
                    '98' => :group_trailer,
                    '99' => :file_trailer }
                     
    FIELDS = {:file_header => [:record_code,:sender_identification, :receiver_identification, :file_creation_date, :file_creation_time,
                               :file_identification_number, :physical_record_length, :block_size, :version_number],
              :group_header => [:record_code,:ultimate_receiver_identification, :originator_identification, :group_status, :as_of_date,
                                :as_of_time, :currency_code, :as_of_date_modifier],
              :group_trailer => [:record_code,:group_control_total, :number_of_accounts, :number_of_records],
              :account_trailer => [:record_code,:account_control_total, :number_of_records],
              :file_trailer => [:record_code,:file_control_total, :number_of_groups, :number_of_records]                          
              }
    
    def initialize
      @data = {}
    end
    
    def self.parse(filename_or_file_contents)
      p = self.new
      p.parse filename_or_file_contents
    end
    
    def parse(filename_or_file_contents)
      if File.exists? filename_or_file_contents
        f = File.open(filename_or_file_contents)
      else
        f = StringIO.new(filename_or_file_contents)
      end
      record = next_line = f.gets.chomp
      count = 1
      loop do
        loop do # gather continuation lines
          next_line = f.gets
          break if next_line.nil?
          next_line.chomp!
          count += 1
          if next_line[0..1] == '88'
            record.sub!(/\/\s*$/,',')
            record += next_line[3..-1]
          else
            break
          end
        end
        record.sub!(/\/\s*$/,'')
        self.send RECORD_CODES[record[0..1]], record
        break if next_line.nil?
        record = next_line
      end
      f.close
      return @data
    end
    
    private
    
    def default_record_parse(type, record)
      h = Hash.new
      values = record.split(',')
      FIELDS[type].each do |k|
        h[k] = values.shift
      end
      return h
    end
                       
    def file_header(record)
      @data[:file_header] = default_record_parse(:file_header, record)
    end
    
    def group_header(record)
      @group = Hash.new
      @group[:group_header] = default_record_parse(:group_header, record)
    end
    
    def account_identifier(record)
      @account = Hash.new
      h = Hash.new
      h[:record_code], record = next_field record
      h[:customer_account_number], record = next_field record
      h[:currency_code], record = next_field record
      h[:summaries] ||= []
      loop do
        s, record = parse_transaction(record)
        h[:summaries] << s
        break if record == ''
      end
      @account[:account_identifier] = h
    end
    
    def parse_transaction(record, detail=false)
      h = Hash.new
      h[:type_code], record = next_field record
      h[:amount], record = next_field record
      unless detail
        h[:item_count], record = next_field record
      end
      h[:funds_type], record = next_field record
      case h[:funds_type]
      when 'S'
        h[:immediate_availability_amount], record = next_field record
        h[:one_day_availability_amount], record = next_field record
        h[:more_than_one_day_availability_amount], record = next_field record
      when 'V'
        h[:value_date], record = next_field record
        h[:value_time], record = next_field record
      when 'D'
        h[:number_of_availability_distributions], record = next_field record
        h[:distributed_availabilties] = []
        h[:number_of_availability_distributions].times do
          days, record = next_field record
          amount, record = next_field record
          if days and amount
            h[:distributed_availabilties] << {availability_in_days: days, availability_amount: amount}
          end
        end
      end
      return [h, record]
    end

    
    def transaction_detail(record)
      t = Hash.new
      t[:record_code], record = next_field record
      h, record = parse_transaction(record, true)
      t.merge! h
      t[:bank_reference_number], record = next_field record
      t[:customer_reference_number], record = next_field record
      t[:text] = record
      (@account[:transactions] ||= []) << t
    end
    
    def account_trailer(record)
      @account[:account_trailer] = default_record_parse(:account_trailer, record)
      (@group[:accounts] ||= []) << @account
    end
    
    def group_trailer(record)
      @group[:group_trailer] = default_record_parse(:group_trailer, record)
      (@data[:groups] ||= []) << @group
    end
    
    def file_trailer(record)
      @data[:file_trailer] = default_record_parse(:file_trailer, record)
    end
    
    def next_field(record)
      a, b, c = record.partition(',')
      return [a, c]
    end
    
  end
  
end
