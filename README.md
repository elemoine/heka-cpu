This repo includes a test-case for what may be a bug in Heka, where Heka
consumes CPU while it has nothing to do.

Running the test-case requires a Git checkout of Heka, built with the
instructions provided in
http://hekad.readthedocs.org/en/latest/installing.html.

Running the test-case:

```shell
make HEKA_DIR=/path/to/heka/checkout/dir
```

`make` will run `hekad`, which will create an rsyslog decoder for each log
file located in the `logs` directory. The `logs` directory is created by
`make` and includes empty log files.

Even though the log files are empty `hekad` will still consume CPU, about
25% on my 8-core laptop. The percentage of CPU is related to the number
of log files/decoders.
