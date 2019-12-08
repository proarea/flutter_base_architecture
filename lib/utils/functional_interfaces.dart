typedef Consumer<T> = void Function(T value);
typedef BiConsumer<T, V> = void Function(T value1, V value2);

typedef SingleFunction<T, R> = R Function(T value);
typedef BiFunction<T, V, R> = R Function(T value1, V value2);

typedef Supplier<T> = T Function();

typedef Runnable = void Function();
