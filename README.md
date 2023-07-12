# Mirror
Configurable "PingPing" IO Bot. You configure a literal string as input, and it will provide a literal string as output.

Every rule can have multiple inputs, and multiple outputs.

For multiple inputs, any item in the list triggers the output.

For multiple outputs, a fair lottery is held between all the options to choose the output which is returned.

```
    hey|hi_hello
```

This above line in the configuration file will cause the bot to return "hello" when you tell it either "hey" or "hi".

```
hi_hello|hey
```

This line causes EITHER "hello" or "hey" to be returned when `hi` is sent.

The barebones configuration file is:

```
	file:filename
	input:>
	learn:$
```
