$(document).on('turbolinks:load', function() {

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

});