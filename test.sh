#! /bin/bash
AWS_ACCOUNT="1111"
CAT <<EOF
line 1
line 2 $AWS_ACCOUNT line 2 continued
line 3
EOF

