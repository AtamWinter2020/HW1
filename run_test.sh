#!/bin/bash

YOUR_ASM=$1
TEST_NUM=$2
STATUS=0
for TEST in tests/test_$2_*
do
TEST_NAME=$(basename -- "${TEST}")

echo "Running $TEST_NAME..."

cat "$YOUR_ASM" "$TEST" > merged.asm
as merged.asm -o merged.o
if [ -f "merged.o" ]; then
	ld merged.o -o merged.out
else
	echo "FAIL"
	STATUS=1
fi
if [ -f "merged.out" ]; then
	timeout 20s ./merged.out
	if [ $? -eq 0 ]; then
		echo "${YOUR_ASM} tested with ${TEST_NAME}: PASS"
		#STATUS=0
	else
		echo "${YOUR_ASM} tested with ${TEST_NAME}: FAIL"
		STATUS=1
	fi
else
	echo "${YOUR_ASM} tested with ${TEST_NAME}: FAIL"
	STATUS=1
fi
rm merged.*
done
exit ${STATUS}
