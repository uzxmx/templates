# vi: sts=2 et
#
# For information about configuration, please visit https://coredns.io/manual/toc/#configuration.
# For information about plugins, please visit https://coredns.io/plugins/ and https://coredns.io/explugins/.

. {
  any
  forward . 8.8.8.8:53
  # Return a custom IP for foo.
  template IN A foo {
    answer "{{ .Name }} 60 IN A 127.0.0.1"
  }
  # Return a custom IP for bar and baz.
  template IN A bar baz {
    answer "{{ .Name }} 60 IN A 127.0.0.1"
  }
  errors
  log
}
