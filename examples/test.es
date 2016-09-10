eval a = 1

eval log "Hello world!"
eval log 3
eval log a

@random [a b] {
  eval c = a
  eval log c
}
