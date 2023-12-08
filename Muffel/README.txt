This is the README for the Muffel Game Maker asset for inline, alarm-less
deferred code execution.

-----------
How to use?
-----------

There are two types of use cases:
1) Execute only once after x seconds or frames
2) Execute every x seconds or frames

The use cases are explained in detail below.

-----------
Execute only once after x seconds or frames
-----------

Say you want something to happen in three seconds (e.g., close a door that the
player went through). Instead of alarms, just write this in the door collision
code, or wherever you detect that the door was opened by the player:

```
open_door();
execute after 2 seconds
	close_door();
done
```

Nice and beautiful. 
We have support for "seconds" and "frames", i.e. you could write the same code
as:

```
open_door();
execute after 120 frames
	close_door();
done
```

Whichever you prefer.

In the special case of "1 second" or "1 frame" you can use the singular word
"second" or "frame" instead of "seconds" or "frames" to make the code more
readable (i.e. "execute every frame" is more readable than "execute every 1
frames", although both are correctly executed). In any other case, please
always use the plural form.

-----------
Execute every x seconds or frames
-----------

What if you want to do something periodically, i.e., rotate an image? Add this
to the create event of that object:

```
execute every frame
	image_angle += 0.1
done
```

Voila. You're done. You can also use "execute every 2 seconds" etc.

-----------
Abort the execution
-----------

What if you want to abort the execution block once it was executed for 10
seconds? We provide three variables for these purposes:
* executed_seconds to check how many seconds have passed since this execution
block was started
* executed_frames is the same for frames
* executed_times to check how often this code block was executed already.

Finally, you can use the "disable" command to disable, exit and remove this
execution code.

So in the scenario above, we could write:

```
execute every 2 seconds
	show_debug_message("hello");
	if(executed_seconds >= 10)
		disable;
done
```

This will print:
```
[00:02] hello
[00:04] hello
[00:06] hello
[00:08] hello
[00:10] hello
```

-----------
Nested execution code-blocks
-----------

You can also nest multiple code-blocks. Just keep in mind that every execution
code-block creates a new instance, so make sure you don't run into issues (see
Troubleshooting below). 
The following code fades an image after 10 seconds.

```
execute after 10 seconds
	execute every frame
		image_alpha -= 0.05
	end
end
```

-----------
Troubleshooting
-----------

There are certain issues that can arise due to the way this asset had to be
implemented.

--- After importing the asset, my code does not compile anymore ---

Answer: We introduced new keywords to Game Maker, which means there are certain
words you can't use as variable or script names anymore: 
"execute", "every", "second", "seconds", "frame", "frames", "done", "after",
"disable", "executed_frames", "executed_seconds", "executed_times".
If you use any of these keywords in your code, you have to change their names,
i.e., if you have a variable somewhere called "done", change it to "is_done" or
"_done".
In any case, Game Maker should highlight the line that lead to the error, so
you should be able to quickly find the line.

--- My block is executed too many times in parallel ---

Answer: Every time Game Maker reaches an execute code-block, it starts a new
instance. Which means that if you run this code:

```
for(int i = 0; i < 3; i++) {
	execute every frame
		image_angle += 0.1
	done
}
```

It will not increase by 0.1 every second, but by 0.3, because there are now
THREE instances running in the background which increase image_angle by 0.1.
Similarly, if you have an execute code-block in your Step-event, you might run
into the same problem (i.e., every frame the step event is called, and if it
hits an unconditional execute code-block, it will start a new instance etc.,
which will eat all your memory and processing power pretty fast).
Always keep in mind that every time Game Maker executes an execute code-block,
it creates a new instance, so you will have multiple instances of the same code
running. You can limit the number of instances, but this is resource hungry and
slow, try to build your game logic in a way that you can avoid this (i.e. put
the execution code-block in a condition so it is only executed once etc.). 

Anyway, here is a solution:

```
for(int i = 0; i < 3; i++) {
	execute every frame
		if(max_instances_reached("rotate image", 1)) {
			disable;
		}
		image_angle += 0.1
	done
}
```

With max_instances_reached you can check how many instances of that execution
code-block are running. To do that, you have to give your execution code-block
a name so Game Maker can differentiate between different code-blocks you have
in your game, and you have to give it a maximum number of instances (in this
case, it's 1).