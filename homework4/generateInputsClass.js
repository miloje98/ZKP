const { buildPoseidonOpt, buildBabyjub } = require("circomlibjs");
const { poseidon1, poseidon2, poseidon3 } = require("poseidon-lite");
const { writeFileSync } = require("fs");
const { IMT } = require("@zk-kit/imt");

async function generateColorado(addressNorth, addressWest, northMin,northMax, westMin, westMax) {
    const addressNorthBig = BigInt(addressNorth);
    const addressWestBig = BigInt(addressWest);

    const salt = 578789985645456879678n;

    const commit = poseidon3([addressNorthBig, addressWestBig, salt]);

    writeFileSync("inputsColorado.json", JSON.stringify({
        addressNorth: addressNorthBig.toString(),
        addresWest: addressWestBig.toString(),
        salt: salt.toString(),
        commit: commit.toString(),
        northMin: northMin.toString(),
        northMax: northMax.toString(),
        westMin: westMin.toString(),
        westMax: westMax.toString(),
    }, null, 2));
}

async function generateHashOfListElements(secretNumber, array) {

    var size = array.length;
    var hashedList = [];
    for (var i=0; i<size;i++) {
        hashedList.push(poseidon1([BigInt(array[i])]));
    }
    writeFileSync("inputsHashedList.json", JSON.stringify({
        publicList: hashedList.toString(),
        secretCode: secretNumber.toString()
    }, null, 2));
}

generateColorado(38,104,37,41,102,109);
generateHashOfListElements(2, [1,2,3,4,5,6,7,8,9,10])