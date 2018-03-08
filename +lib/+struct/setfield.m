function s=setfield(s,path,value)
fields = strsplit(path,'/');
s = setfield(s,fields{:},value);