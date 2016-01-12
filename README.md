This repo includes a test-case for what may be a bug in Heka, where Heka
consumes CPU while it has nothing to do.

Running the test-case requires a Git checkout of Heka, built with the
instructions provided in
http://hekad.readthedocs.org/en/latest/installing.html.

Running the test-case:

```shell
make HEKA_DIR=/path/to/heka/checkout/dir
```

`make` will run `hekad`, which will process the log messages included
in the log files located in the `logs` directory (created by `make`).

`hekad` will consume 400% of CPU while processing the logs, which is expected
(`max_proc` is set to 4 in `heka.conf`). BUT it will still consume a fair
amount of CPU (about 25% on my laptop) after all the logs have been processed,
doing nothing.
