# Bai Parser

Ruby BAI2 Bank File parser.  Takes a bank file as input and outputs the data as a Ruby hash.  You can then use a custom writer class to output the data as needed for your purposes.

## Installation

Add this line to your application's Gemfile:

    gem 'bai_parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bai_parser

## Usage

``` ruby
require "bai_parser"
data = BAI::Parser.parse "BAI-File-From-Bank.bai"

# The resulting hash will look like this.

{:file_header=>
  {:record_code=>"01",
   :sender_identification=>"021000018",
   :receiver_identification=>"55287",
   :file_creation_date=>"051025",
   :file_creation_time=>"0600",
   :file_identification_number=>"1",
   :physical_record_length=>"80",
   :block_size=>"080",
   :version_number=>"2"},
 :groups=>
  [{:group_header=>
     {:record_code=>"02",
      :ultimate_receiver_identification=>"55287",
      :originator_identification=>"021000018",
      :group_status=>"1",
      :as_of_date=>"051022",
      :as_of_time=>"0000",
      :currency_code=>nil,
      :as_of_date_modifier=>nil},
    :accounts=>
     [{:account_identifier=>
        {:record_code=>"03",
         :customer_account_number=>"0101999999",
         :currency_code=>"",
         :summaries=>
          [{:type_code=>"015",
            :amount=>"+00000004060801",
            :item_count=>"",
            :funds_type=>""},
           {:type_code=>"045",
            :amount=>"+00000003836014",
            :item_count=>"",
            :funds_type=>""},
           {:type_code=>"100",
            :amount=>"+00000001589285",
            :item_count=>"00008",
            :funds_type=>""},
           {:type_code=>"400",
            :amount=>"+00000001831945",
            :item_count=>"00002",
            :funds_type=>""},
           {:type_code=>"040",
            :amount=>"+00000004059283",
            :item_count=>"",
            :funds_type=>""}]},
       :transactions=>
        [{:record_code=>"16",
          :type_code=>"175",
          :amount=>"000000000346685",
          :funds_type=>"Z",
          :bank_reference_number=>"00087829876",
          :customer_reference_number=>"Miami",
          :text=>"DEPOSIT LOCATION, ITEM COUNT 00004"},
         {:record_code=>"16",
          :type_code=>"175",
          :amount=>"000000000336375",
          :funds_type=>"Z",
          :bank_reference_number=>"00088137654",
          :customer_reference_number=>"Fort Lauderdale",
          :text=>"DEPOSIT LOCATION, ITEM COUNT 00008"},
         {:record_code=>"16",
          :type_code=>"175",
          :amount=>"000000000262575",
          :funds_type=>"Z",
          :bank_reference_number=>"00086095789",
          :customer_reference_number=>"Boca Raton",
          :text=>"DEPOSIT LOCATION, ITEM COUNT 00007"},
         {:record_code=>"16",
          :type_code=>"175",
          :amount=>"000000000186250",
          :funds_type=>"Z",
          :bank_reference_number=>"00087793469",
          :customer_reference_number=>"Palm Beach",
          :text=>"DEPOSIT LOCATION, ITEM COUNT 00001"},
         {:record_code=>"16",
          :type_code=>"175",
          :amount=>"000000000167775",
          :funds_type=>"Z",
          :bank_reference_number=>"00087792345",
          :customer_reference_number=>"Atlanta - Downtown",
          :text=>"DEPOSIT LOCATION, ITEM COUNT 00002"},
         {:record_code=>"16",
          :type_code=>"175",
          :amount=>"000000000127200",
          :funds_type=>"Z",
          :bank_reference_number=>"00088101927",
          :customer_reference_number=>"Atlanta - Lenox",
          :text=>"DEPOSIT LOCATION, ITEM COUNT 00010"},
         {:record_code=>"16",
          :type_code=>"175",
          :amount=>"000000000083875",
          :funds_type=>"Z",
          :bank_reference_number=>"00088157722",
          :customer_reference_number=>"NYC - 5th Ave",
          :text=>"DEPOSIT LOCATION, ITEM COUNT 00002"},
         {:record_code=>"16",
          :type_code=>"175",
          :amount=>"000000000078550",
          :funds_type=>"Z",
          :bank_reference_number=>"00086079576",
          :customer_reference_number=>"NYC - Village",
          :text=>"DEPOSIT LOCATION, ITEM COUNT 00002"},
         {:record_code=>"16",
          :type_code=>"451",
          :amount=>"000000001821445",
          :funds_type=>"Z",
          :bank_reference_number=>"ACD0410288888888",
          :customer_reference_number=>"01650088",
          :text=>"01650088 ABC Retailers - BNY"},
         {:record_code=>"16",
          :type_code=>"555",
          :amount=>"000000000010500",
          :funds_type=>"Z",
          :bank_reference_number=>"VVN0410298989898",
          :customer_reference_number=>"NYC - Trump",
          :text=>"DEPOSITED CHK RETURN     00000000"}],
       :account_trailer=>
        {:record_code=>"49",
         :account_control_total=>"000000018798558",
         :number_of_records=>"23"}},
      {:account_identifier=>
        {:record_code=>"03",
         :customer_account_number=>"6901355555",
         :currency_code=>"",
         :summaries=>
          [{:type_code=>"015",
            :amount=>"+00000013561120",
            :item_count=>"",
            :funds_type=>""},
           {:type_code=>"045",
            :amount=>"+00000013561120",
            :item_count=>"",
            :funds_type=>""},
           {:type_code=>"100",
            :amount=>"+00000000063500",
            :item_count=>"00001",
            :funds_type=>""},
           {:type_code=>"400",
            :amount=>"+00000000070000",
            :item_count=>"00001",
            :funds_type=>""},
           {:type_code=>"040",
            :amount=>"+00000013561120",
            :item_count=>"",
            :funds_type=>""}]},
       :transactions=>
        [{:record_code=>"16",
          :type_code=>"175",
          :amount=>"000000000063500",
          :funds_type=>"Z",
          :bank_reference_number=>"00086081234",
          :customer_reference_number=>"LA",
          :text=>"DEPOSIT LOCATION, ITEM COUNT 00001"},
         {:record_code=>"16",
          :type_code=>"451",
          :amount=>"000000000070000",
          :funds_type=>"Z",
          :bank_reference_number=>"ACD0410288553311",
          :customer_reference_number=>"01650090",
          :text=>"01650090 ABC Retailers - BNY"}],
       :account_trailer=>
        {:record_code=>"49",
         :account_control_total=>"000000040950360",
         :number_of_records=>"7"}}],
    :group_trailer=>
     {:record_code=>"98",
      :group_control_total=>"000000059748918",
      :number_of_accounts=>"2",
      :number_of_records=>"32"}}],
 :file_trailer=>
  {:record_code=>"99",
   :file_control_total=>"000000059748918",
   :number_of_groups=>"1",
   :number_of_records=>"34"}}

# Then you can use a custom writer to output the data as needed such as to a csv file
MyCustomBAIWriter.write data
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
