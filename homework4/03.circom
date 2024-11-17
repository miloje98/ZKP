pragma circom 2.1.6;

include "circomlib/poseidon.circom";
include "circomlib/comparators.circom";

template CheckSecretCode(N) {
    signal input secretCode;           
    signal input publicList[N];        
    signal output answer;               

    signal hashOfSecret;
    component hash = Poseidon(1);
    hash.inputs[0] <== secretCode;
    hashOfSecret <== hash.out;

    signal numberOfMatches[N+1];
    numberOfMatches[0] <== 0;

    component equal[N];

    for (var i = 0; i < N; i++) {
        equal[i] = IsEqual();
        equal[i].in[0] <== publicList[i];    
        equal[i].in[1] <== hashOfSecret;      

        numberOfMatches[i+1] <== numberOfMatches[i] + equal[i].out;   
    }

    component checkAnswer = IsEqual();
    checkAnswer.in[0] <== numberOfMatches[N];     
    checkAnswer.in[1] <== 1;                   

    answer <== checkAnswer.out;   
}

component main { public [ publicList ] } = CheckSecretCode(10);

/* INPUT = {
    "publicList": ["18586133768512220936620570745912940619677854269274689475585506675881198879027","8645981980787649023086883978738420856660271013038108762834452721572614684349","6018413527099068561047958932369318610297162528491556075919075208700178480084","9900412353875306532763997210486973311966982345069434572804920993370933366268","19065150524771031435284970883882288895168425523179566388456001105768498065277","4204312525841135841975512941763794313765175850880841168060295322266705003157","7061949393491957813657776856458368574501817871421526214197139795307327923534","8761383103374198182292249284037598775384145428470309206166618811601037048804","5199363853932272446084541931873785938987820779897294035064941545455873932186","17853941289740592551682164141790101668489478619664963356488634739728685875777"],
    "secretCode": "2"
} */