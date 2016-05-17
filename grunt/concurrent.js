module.exports = {
    server: [
        'coffee:server',
        'stylus:server'
    ],
    test: [
        'coffee:server',
        'coffee:test',
        'stylus:test'
    ],
    dist: [
        'imagemin',
        'svgmin'
    ]
}