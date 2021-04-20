function [x_train, y_train, x_test, y_test] = ...
                splitData( features, labels, train_percent )

    include = rand(size(labels)) < train_percent;
    x_train = features(include,:);
    y_train = labels(include,:);
    x_test = features(~include,:);
    y_test = labels(~include,:);

end