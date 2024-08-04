cat << EOF | crontab -
0 0 * * MON tg-scheduled-pfp set-profile-picture --md5 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  # Monday
0 0 * * TUE tg-scheduled-pfp set-profile-picture --md5 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  # Tuesday
0 0 * * WED tg-scheduled-pfp set-profile-picture --md5 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  # Wednesday
0 0 * * THU tg-scheduled-pfp set-profile-picture --md5 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  # Thursday
0 0 * * FRI tg-scheduled-pfp set-profile-picture --md5 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  # Friday
0 0 * * SAT tg-scheduled-pfp set-profile-picture --md5 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  # Saturday
0 0 * * SUN tg-scheduled-pfp set-profile-picture --md5 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  # Sunday
EOF
