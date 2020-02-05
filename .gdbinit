source ~/.gdbinit.autoload
# above includes add-auto-load-safe-path /path/to/.gdbinit commands
set history save on

source ~/.gdbinit-gef.py
# above is https://github.com/hugsy/gef

#source ~/.gdbinit.1
# above is the .gdbinit from https://github.com/cyrus-and/gdb-dashboard


define xxd
  if $argc < 2
    set $size = sizeof(*$arg0)
  else
    set $size = $arg1
  end
  dump binary memory /tmp/dump.bin $arg0 ((void *)$arg0)+$size
  eval "shell xxd -o %d /tmp/dump.bin; rm /tmp/dump.bin", ((void *)$arg0)
end
document xxd
  Dump memory with xxd command (keep the address as offset)

  xxd addr [size]
    addr -- expression resolvable as an address
    size -- size (in byte) of memory to dump
            sizeof(*addr) is used by default
end

define raw-stack
  gef config context.show_stack_raw $arg0
  context
end
document raw-stack
  Show hexdump (True) or pretty printed stack in gef context

  raw-stack [True/False]
end

define stack-lines
  gef config context.nb_lines_stack $arg0
  context
end
document stack-lines
  Set number of stack lines to display in gef context

  stack-lines [n]
end
