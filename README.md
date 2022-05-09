## real-time-stock-prices
This is a sample application to show how cache channels work. 

## Running
```shell
$ bundle install
$ ruby app.rb -o 0.0.0.0
```

## Updating stock prices
```shell
$ curl -i -X POST http://localhost:4567/trigger
```
