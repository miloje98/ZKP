pragma circom 2.1.6;

include "circomlib/poseidon.circom";
include "circomlib/comparators.circom";

template ColoradoCheck(N) {
    assert(N <= 252); 
    signal input northMin;
    signal input northMax;
    signal input westMin;
    signal input westMax;
    signal input commitment;
    signal input addressWest;
    signal input addressNorth;
    signal input salt;

    signal output answer;

    component hash = Poseidon(3);
    hash.inputs[0] <== addressNorth;
    hash.inputs[1] <== addressWest;
    hash.inputs[2] <== salt;

    hash.out === commitment;

    component westMaxCheck = LessThan(N);
    westMaxCheck.in[0] <== addressWest;
    westMaxCheck.in[1] <== westMax;

    component westMinCheck = GreaterThan(N);
    westMinCheck.in[0] <== addressWest;
    westMinCheck.in[1] <== westMin;

    signal westRange;
    westRange <== westMaxCheck.out * westMinCheck.out;

    component northMaxCheck = LessThan(N);
    northMaxCheck.in[0] <== addressNorth;
    northMaxCheck.in[1] <== northMax;

    component northMinCheck = GreaterThan(N);
    northMinCheck.in[0] <== addressNorth;
    northMinCheck.in[1] <== northMin;

    signal northRange;
    northRange <== northMaxCheck.out * northMinCheck.out;


    answer <== northRange * westRange;
    

}

component main { public [commitment,northMin, northMax, westMin, westMax] } = ColoradoCheck(252);
/* INPUT = {
"addressNorth": "38",
"addressWest": "104",
"salt": "578789985645456879678",
"commitment": "21079584169133299665030214927873152536602152814577123604147627733629532007485",
"northMin": "37",
"northMax": "41",
"westMin": "102",
"westMax": "109"
} */