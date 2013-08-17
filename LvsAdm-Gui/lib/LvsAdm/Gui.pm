package LvsAdm::Gui;
use Dancer ':syntax';
use DBI;
use File::Spec;
use File::Slurp;
use Template;
use Dancer::Plugin::Database;
use Dancer::Plugin::SimpleCRUD;
use Config::Ldirectord;

our $VERSION = '0.1';

my $flash;

sub set_flash {
       my $message = shift;

       $flash = $message;
}

sub get_flash {

       my $msg = $flash;
       $flash = "";

       return $msg;
}


hook before_template => sub {
       my $tokens = shift;

       $tokens->{'css_url'} = request->base . 'css/style.css';
       $tokens->{'login_url'} = uri_for('/login');
       $tokens->{'logout_url'} = uri_for('/logout');
};


simple_crud(
    record_title => 'vs',
    db_table => 'vs',
    prefix => '/vs',
#    template => 'vs.tt',
    deleteable => 1,
    labels => {     # More human-friendly labels for some columns
        vsblock => 'Name',
        virtual => 'Destination',
        real => 'members',
    },
    display_columns  => [ qw( vsblock virtual protocol real scheduler request receive login passwd ) ],
    acceptable_values => {
       scheduler => [
           [ 'wrr', 'weight round robin'],
           [ 'rr', 'round robin'],
       ],
    },
    auth => {
        view => {
            require_login => 1,
        },
        edit => {
            require_role => 'editor',
        },
    },

);

simple_crud(
    record_title => 'global',
    db_table => 'global',
    prefix => '/global',
#    template => 'vs.tt',
    labels => {     # More human-friendly labels for some columns
        autoreload => 'auto reload',
        logfile => 'log file',
    },
    display_columns  => [ qw( autoreload logfile ) ],
    acceptable_values => {
       autoreload => [
           [ 'yes', 'yes'],
           [ 'no', 'no'],
       ],
    },
    auth => {
        view => {
            require_login => 1,
        },
        edit => {
            require_role => 'editor',
        },
    },

);

any ['get', 'post'] => '/login' => sub {
       my $err;

       if ( request->method() eq "POST" ) {
               # process form input
               if ( params->{'username'} ne setting('username') ) {
                       $err = "Invalid username";
               }
               elsif ( params->{'password'} ne setting('password') ) {
                       $err = "Invalid password";
               }
               else {
                       session 'logged_in' => true;
                       set_flash('You are logged in.');
                       return redirect '/';
               }
       }

       # display login form
       template 'login.tt', {
               'err' => $err,
       };

};


get '/' => sub {
    template 'index.tt';
};

get '/logout' => sub {
       session->destroy;
       set_flash('You are logged out.');
       redirect '/';
};





true;
