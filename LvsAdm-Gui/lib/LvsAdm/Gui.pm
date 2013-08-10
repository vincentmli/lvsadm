package LvsAdm::Gui;
use Dancer ':syntax';
use DBI;
use File::Spec;
use File::Slurp;
use Template;
use Dancer::Plugin::Database;
use Dancer::Plugin::SimpleCRUD;

set 'session'      => 'Simple';
set 'username'     => 'admin';
set 'password'     => 'password';


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

simple_crud(
    record_title => 'vs',
    db_table => 'vs',
    prefix => '/vs',
#    template => 'index.tt',
    labels => {     # More human-friendly labels for some columns
        vsblock => 'Name',
        virtual => 'Destination',
        real => 'members',
    },
    display_columns  => [ qw( vsblock virtual ) ],
    acceptable_values => {
       scheduler => [
           [ 'wrr', 'weight round robin'],
           [ 'rr', 'round robin'],
       ],
    },

);


hook before_template => sub {
       my $tokens = shift;

       $tokens->{'login_url'} = uri_for('/login');
       $tokens->{'logout_url'} = uri_for('/logout');
};


get '/' => sub {
    #my $sql = 'select id, title, text from entries order by id desc';
    my $sql = 'select * from vs order by id desc';
    my $sth = database->prepare($sql);
    $sth->execute or die $sth->errstr;
    template 'index', {
	'msg' => get_flash(),
	'add_entry_url' => uri_for('/add'),
	'entries' => $sth->fetchall_hashref('id'),
    };
};


post '/add' => sub {
       if ( not session('logged_in') ) {
               send_error("Not logged in", 401);
       }

       #my $sql = 'insert into entries (title, text) values (?, ?)';
       my $sql = 'insert into vs (vsblock, text) values (?, ?)';
       my $sth = database->prepare($sql);
       #$sth->execute(params->{'title'}, params->{'text'}) or die $sth->errstr;
       $sth->execute(params->{'vsblock'}, params->{'virtual'}) or die $sth->errstr;

       set_flash('New entry posted!');
       redirect '/';
};

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

get '/logout' => sub {
       session->destroy;
       set_flash('You are logged out.');
       redirect '/';
};



true;
