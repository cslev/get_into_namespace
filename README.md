# get_into_namespace
Simple script to get into a network namespace on linux with a colorized BASH prompt to allow you easily identify where you at 

## Usage
Let's create a namespace for testing purposes, then get into it.
```
$ sudo ip netns add test
$ ./get_into_ns.sh -n test

<test> root  /home/lele/git/get_into_namespace# 

```



