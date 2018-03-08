function figure(varargin)
Q = lib.module.struct(...
	'width',		'\textwidth',...
	'tplfile',		'+lib/+view/+latex/figure.tpl',...
	'filename',		'figure',...
	'filetype',		'pdf',...
	varargin{:}...
);

if isfield(Q,'path')
	mkdir(Q.path);
	
	Q.texpath = [Q.path Q.filename '.tex'];
	Q.imgpath = [Q.path Q.filename];
	Q.imgfile = [Q.filename '.' Q.filetype];
end

if isfield(Q,'figure')
	lib.view.file.figure(...
		'figure',	Q.figure,...
		'filepath',	Q.imgpath,...
		'type',		Q.filetype ...
	);
end

str = fileread(Q.tplfile);
str = regexprep(str,'{{width}}',lib.escape(Q.width));
str = regexprep(str,'{{imgpath}}',lib.escape(Q.imgfile));
str = regexprep(str,'{{caption}}',lib.escape(Q.caption));
str = regexprep(str,'{{label}}',lib.escape(Q.label));

fh = fopen(Q.texpath,'w');
fwrite(fh,str);
fclose(fh);