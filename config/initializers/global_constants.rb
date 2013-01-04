#encoding utf-8
# also notice the call to 'freeze'
#default

GLOBAL_INPUT_MAX_LENGTH = 10000

ACCECPTED_IMAGES = 'image/png,image/gif,image/jpg,image/jpeg'
GENERAL_TIME_FORMAT = "%m-%d %H:%M"
VALID_URL_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
