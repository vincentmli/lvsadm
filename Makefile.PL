use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'		=> 'Config::Ldirectord',
    'VERSION_FROM'	=> 'Ldirectord.pm', 
    'PREREQ_PM'		=> {},
    ($] >= 5.005 ?    (ABSTRACT_FROM => 'Ldirectord.pm', AUTHOR => 'Sherzod B. Ruzmetov <sherzodr@cpan.org>') : ()),
);
