It is a wrapper around libcomcom (Command Communication Library):
https://github.com/vporton/libcomcom

libcomcom does not work on Windows.

**Description**

Spawn an OS command with given input and receive its output.

The main feature of this library is deadlock avoidance.
(Deadlock in this case is when your program can't write to the input
of another program because of waiting for its output which does not
happen because of no input, so a vicious circle leading to infinite
waiting time.)

**Usage**

For an example usage, see test.d file.

**Projects**

To support this project:
- Send money to PayPal porton@narod.ru or https://paypal.me/victorporton
- Send BitCoin to 1BdUaP3uRuUC1TXcLgxKXdWWfQKXL2tmqa
- Send Ether to 0x36A0356d43EE4168ED24EFA1CAe3198708667ac0
- Buy tokens at https://crypto4ngo.org/project/view/4

The library is to be used in the following project:
https://github.com/vporton/xml-boiler
(which I am going to rewrite in D programming language).
