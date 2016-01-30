module.exports = (grunt) ->
  'use strict'

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    # Task configuration
    clean:
      dist: 'dist'

    csscomb:
      options:
        config: 'less/.csscomb.json'
      dist:
        expand: true
        cwd: 'dist/css'
        src: ['*.css', '!*.min.css']
        dest: 'dist/css'

    cssmin:
      options:
        compatibility: 'ie8'
        keepSpecialComments: '*'
        advanced: false
      dist:
        expand: true
        cwd: 'dist/css'
        src: ['*.css', '!*.min.css']
        dest: 'dist/css'
        ext: '.min.css'

    copy:
      dist:
        expand: true
        cwd: 'fonts'
        src: '**'
        dest: 'dist/fonts'

    less:
      dist:
        options:
          strictMath: true
          sourceMap: true
          outputSourceFiles: true
        expand: true
        cwd: 'less'
        src: ['*.less','!_*.less']
        dest: 'dist/css'
        ext: '.css'

    watch:
      less:
        files: 'less/*.less'
        tasks: ['dist-css']

  require('load-grunt-tasks')(grunt, { scope: 'devDependencies' })
  require('time-grunt')(grunt)

  grunt.registerTask('dist-css', ['less:dist', 'csscomb:dist', 'cssmin:dist'])
  grunt.registerTask('dist', ['clean', 'dist-css', 'copy'])

  # Default task
  grunt.registerTask('default', ['dist'])
