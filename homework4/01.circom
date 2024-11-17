pragma circom 2.1.6;

include "circomlib/comparators.circom";

template FactorizationCheck () {
    signal input priv1;
    signal input priv2;
    signal input priv3;
    signal input priv4;
    signal input priv5;
    signal input public_number;
    signal output answer;

    signal product12;
    signal product123;
    signal product1234;
    signal product12345;

    product12 <== priv1*priv2;
    product123 <== product12*priv3;
    product1234 <== product123*priv4;
    product12345 <== product1234*priv5;

    component check = IsEqual();
    check.in[0] <== product12345;
    check.in[1] <== public_number;

    answer <== check.out;
}

component main { public [ public_number ] } = FactorizationCheck();

/* INPUT = {
    "public_number": "720",
    "priv1": "2",
    "priv2": "3",
    "priv3": "4",
    "priv4": "5",
    "priv5": "6"
} */