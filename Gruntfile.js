module.exports = function(grunt) {
    var comments = '/*\n' +
                   ' * Name: SewisePlayer framework 2.5.2\n' +
                   ' * Author: Jack Zhang\n' +
                   ' * Website: http://player.sewise.com\n' +
                   ' * Date: December 26, 2014\n' +
                   ' * Copyright: 2013-2014, Sewise\n' +
                   ' * Mail: jackzhang1204@gmail.com\n' +
                   ' * QQ: 237432172\n' +
                   ' * \n */\n\n';

    var srcFiles = [
                    'src/com/sewise/base/core/Base.js',
                    'src/com/sewise/interfaces/player/IVodPlayer.js',
                    'src/com/sewise/interfaces/skin/IVodSkin.js',
                    'src/com/sewise/interfaces/player/ILivePlayer.js',
                    'src/com/sewise/interfaces/skin/ILiveSkin.js',
                    'src/com/sewise/base/globals/GlobalConst.js',
                    'src/com/sewise/base/globals/GlobalVars.js',
                    'src/com/sewise/base/events/CommandDispatcher.js',
                    'src/com/sewise/base/events/Events.js',
                    'src/com/sewise/base/utils/Utils.js',
                    'src/com/sewise/base/params/GlobalParams.js',
                    'src/com/sewise/base/params/H5Params.js',
                    'src/com/sewise/base/medias/PlayerSkinLoader.js',
                    'src/com/sewise/base/medias/vod/VodVideo.js',
                    'src/com/sewise/base/medias/vod/VodAudio.js',
                    'src/com/sewise/base/medias/vod/VodMediaConsole.js',
                    'src/com/sewise/base/medias/vod/VodMediaStreams.js',
                    'src/com/sewise/base/medias/live/LiveVideo.js',
                    'src/com/sewise/base/medias/live/LiveMediaConsole.js',
                    'src/com/sewise/base/medias/live/LiveMediaStreams.js',
                    'src/com/sewise/base/medias/PlayerCommon.js',
                    'src/com/sewise/base/external/FlashExternalInterface.js',
                    'src/com/sewise/base/external/Html5ExternalInterface.js',
                    'src/com/sewise/base/dom/ContextMenu.js',
                    'src/com/sewise/base/SewisePlayer.js'
                ];

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        /*concat: {
            options: {
                banner: comments,
                stripBanners: true,
                separator: '\n\n'
            },
            dist: {
                src: srcFiles,
                dest: 'bin/<%= pkg.name %>.js'
            }
        },*/
        uglify: {
            options: {
                banner: comments,
                compress: {
                    drop_console: true
                }
            },
            my_target: {
                files: {
                    'bin/<%= pkg.name %>.min.js': srcFiles
                }
            }
        },
        jshint: {
            files: ['gruntfile.js', srcFiles],
            options: {
                globals: {
                    jQuery: true,
                    console: true,
                    module: true
                }
            }
        },
        watch: {
            files: ['<%= jshint.files %>'],
            tasks: ['jshint']
        }
        
        
    });
    
    //grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-watch');
    
    grunt.registerTask('test', ['jshint']);
    //grunt.registerTask('default', ['uglify', 'concat', 'jshint']);
    grunt.registerTask('default', ['uglify', 'jshint']);
    
};