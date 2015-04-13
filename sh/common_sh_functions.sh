function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

trim() { echo $1; }
