# $1 = dir to create then move into
cdmkdir() {
    mkdir -p $1
    cd $1
}

# $@ = packages to install
yins() {
       sudo yum -y install "$@"
}
