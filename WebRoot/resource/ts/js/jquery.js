$(document).ready(function(){  
            $(".text_login").focus(function(){  
                if($(this).val()=='user name' || $(this).val()=='password'){  
                    $(this).val('');  
                }  
                if($(this).attr('id')=='password1'){  
                    $(this).hide();  
                    $('#password2').show();  
                    $('#password2').focus();  
                }  
            });  
            $(".text_login").blur(function(){  
                if($(this).attr('id')=='password' && $(this).val()==''){  
                    $(this).hide();  
                    $('#password1').show();  
                    $('#password1').val('password');  
                }  
                else if($(this).attr('id')=='uname' && $(this).val()=='' ){  
                    $(this).val('user name');  
                }  
            });  
        });  