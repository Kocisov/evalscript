eval obj from './object'

eval (obj) {
  eval log obj
}

@random [a b] {
  eval c = a
  eval log c
}

@noInput [!] {
  eval log 'function without input'
}

@check[that fn] {
  eval (that) {
    fn(!)
  }
}

eval Q [
  "Hello"
  "How"
  "Are"
  "You"
  "Doing"
]

eval Q
