Feature: consumer-avro-key-value

  Background:
    Given subject
      | name                 | alias      | format |
      | kapoeira.avrovaluev1 | avro_value | avro   |
    And input topic
      | topic                                              | alias    | key_type | value_type |
      | private.euw.kapoeira-dsl-it.avrovalue.tracking.raw | topic_in | string   | avro_value |
    And output topic
      | topic                                              | alias     | key_type | value_type | readTimeoutInSecond |
      | private.euw.kapoeira-dsl-it.avrovalue.tracking.raw | topic_out | string   | avro_value | 10                  |
    And var uuid = call function : uuid

  Scenario: Produce a record
    When records with key and value are sent
      | topic_alias | key              | value                                                                          |
      | topic_in    | aTestKey_${uuid} | {"anInt": 1, "aString": "myString1", "anOptionalString": { "string": "test"} } |
      | topic_in    | aTestKey_${uuid} | {"anInt": 2, "aString": "myString2", "anOptionalString": null }                |
    Then expected records
      | topic_alias | key              | value       |
      | topic_out   | aTestKey_${uuid} | aliasValue1 |
      | topic_out   | aTestKey_${uuid} | aliasValue2 |
    And assert aliasValue1 $.anInt == 1
    And assert aliasValue1 $.aString == "myString1"
    And assert aliasValue1 $.anOptionalString == "test"
    And assert aliasValue2 $.anInt == 2
    And assert aliasValue2 $.aString == "myString2"
    And assert aliasValue2 $.anOptionalString == null
