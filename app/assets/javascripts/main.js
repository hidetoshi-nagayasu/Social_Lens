$(document).on('turbolinks:load', function() {

    /**
     * textareaのスクロール高さを取得する関数
     * @param textareaClass スクロールの高さを取得したいtextareaのclass名
     * @return Integer 
     */
    const getTextareaHeight = (textareaClass) => {
        return $('.' + textareaClass).prop('scrollHeight');
    }

    // init textarea
    $('.post-textarea').height(100);
    $('#post_text').css('lineHeight', '20px');

    var post_edit_height = getTextareaHeight('post-textarea-edit');
    $('.post-textarea-edit').height(post_edit_height);

    /**
     * textareaの改行に従ってheightが上下する処理
     */
    $('#post_text').on('input', function(e) {
        if(e.target.scrollHeight > e.target.offsetHeight) {
            $(e.target).height(e.target.scrollHeight);
        } else {          
            var lineHeight = Number( $(e.target).css('lineHeight').split('px')[0] );
            
            while (true) {
                $(e.target).height($(e.target).height() - lineHeight); 
                if(e.target.scrollHeight > e.target.offsetHeight) {
                    $(e.target).height(e.target.scrollHeight);
                    break;
                }
            }
        }
    });

    /**
     * 新規投稿モーダル表示時にtextareaにフォーカスする処理
     */
    $('#newPostModal').on('shown.bs.modal', function() {
        $(this).find('textarea').focus();
    });

    /**
     * コメントアイコンのクリック時にコメントinputにフォーカスする処理
     */
    $('.comment-icon').on('click', function() {
        let this_comment_input = $(this).parents('.card').find('.add-comment-input').focus();
    });

    /**
     * コメントテキストhover時にアクションメニューを表示する処理
     */
    $('.comment-one').hover(
        function() {
            $(this).find('.comment-dropdown-menu').show();
        },
        function() {
            $(this).find('.comment-dropdown-menu').hide();
        }
    );

    /**
     * ファイルアップロードボタン押下時の処理
     */
    $('#js-selectFile').on('click', 'button', function () {
        $('.js-upload').click();
        return false;
    });
    
    /**
     * ファイル選択後にファイル名表示する処理
     */
    $('.js-upload').on('change', function() {
        //選択したファイル情報を取得し変数に格納
        var file = $(this).prop('files')[0];
        //アイコンを選択中に変更
        $('#js-selectFile').find('.icon').addClass('select').html('選択中');
        //未選択→選択の場合（.filenameが存在しない場合）はファイル名表示用の<div>タグを追加
        if(!($('.filename').length)){
            $('#js-selectFile').append('<div class="filename"></div>');
        };
        //ファイル名を表示
        $('.filename').html('ファイル名：' + file.name);
    });

});