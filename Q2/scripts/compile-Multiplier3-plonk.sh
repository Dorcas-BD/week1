#!/bin/bash

# [assignment] create your own bash script to compile Multipler3.circom using PLONK below#!/bin/bash

cd contracts/circuits

mkdir Multiplier3_plonk

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping"
else 
    echo "Downloading powersOfTau28_hez_final_10.ptau"
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo 'Compiling Multiplier3_plonk.circom'

circom Multiplier3_plonk.circom --r1cs --wasm --sym
snarkjs r1cs Multiplier3_plonk.r1cs

snarkjs plonk setup Multiplier3_plonk.r1cs powersOfTau28_hez_final_10.ptau Multiplier3_plonk/circuit_0000.zkey
snarkjs zkey contribute Multiplier3_plonk/circuit_0000.zkey Multiplier3_plonk/circuit_final.zkey --name="Dorcas" -v -e="I am a cryptographer"
snarkjs zkey export verificationkey Multiplier3_plonk/circuit_final.zkey Multiplier3_plonk/verification_key.json

snarkjs zkey export solidityverifier Multiplier3_plonk/circuit_final.zkey ../Multiplier3Verifier.sol

cd ../..