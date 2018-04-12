set history save on
set history filename ~/.gdb-history
set history size 1000
set pagination off
set confirm off
set print pretty on
set history remove-duplicates 1

define hook-next
  refresh
end
