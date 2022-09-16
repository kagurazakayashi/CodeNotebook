// 去掉 px

parseInt('245px', 10);
'245px'.substring(0, '245px'.length-2);
parseFloat('245px', 10);
'245px'.split('px')[0]
'245px'.replace(/ *px/g, '')
