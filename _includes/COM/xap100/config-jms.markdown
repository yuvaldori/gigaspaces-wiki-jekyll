
{: .table .table-bordered .table-condensed}
| Property name | Description | Default   |
|-----|---|--|
| com.gs.jms.compressionMinSize | JMS - The minimum size (in bytes) which from where we start to compress the message body. e.g. if a 1 MB Text **JMSMessage** body is sent, and the **compressionMinSize** value is 500000 (0.5MB) then we will compress that message body (only), otherwise we will send (write) it as is. | **500000** |

{%comment%}
| com.gs.jms.compressionMinSize | Compresses a JMS text message's data if its size is larger than a configured value (threshold). The message data is compressed when sent, and decompressed when received. The value assigned should be in bytes. | **500000** (0.5 MB) |
{%endcomment%}