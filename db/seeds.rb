# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

u = User.create(:name => "Starving Musician")

jc = Artist.create(:name => "Johnny Cash")
ct = Artist.create(:name => "Charles Trenet")

Song.create(:user => u, :artist => jc, :name => "You Are My Sunshine", :body => <<EOB
{title: You Are My Sunshine}

{c:Verse 1}
[G]The other night dear as I lay sleeping
[G7]I dreamed I [C]held you in my [G]arms
[G7]But when I a[C]woke dear I was mis[G]taken
So I hung my [D7]head and [G]cried

{c:Chorus}
{soc}
You are my sunshine my only sunshine
[G7]You make me [C]happy when skies are [G]gray
[G7]You'll never [C]know dear how much I [G]love you
Please don't take [D7]my sunshine a[G]way
{eoc}

{c:Verse 2}
I'll always love you and make you happy
[G7]If you will [C]only say the [G]same
[G7]But if you [C]leave me and love an[G]other
You'll regret [D7]it all some [G]day

{c:Verse 3}
You told me once dear you really loved me
[G7]And no one [C]else could come be[G]tween
[G7]But now you've [C]left me and love an[G]other
You have shattered [D7]all of my [G]dreams
EOB
)

Song.create(:user => u, :artist => ct, :name => "La Mer", :body => <<EOB
{title: La Mer}

[C]La Mer[Am][F]
[G7]Qu'on voit dans[C]er[Am]
Le [F]long [G7]des golfes [C]clairs[E7][Am]
[G7]A des ref[C]lets d'ar[Am]gent
[F]La mer[A7][Dm]
Des [G]ref[E7]lets chan[Am]geants[F]
Sous la [D7]plui-[G][G7]e...


[C]La Mer[Am][F]
[G7]Au ciel d'é[C]té[Am]
Con[F]fond [G7]ses blancs mou[C]tons[E7][Am]
[G7]Avec les [C]anges si [Am]purs,
[F]La mer[A7][Dm]
Ber[G]gèr[E7]e D'A-[Am]zur [F]infi-[Dm7]ni- [G7]-  [C]E

[B7]Voy-[E]ez[C#m][F#m]
[B7]Près des é[E]tangs[C#m]
Ces [F#m]grands [B7]roseaux moui[E]llés
[D7]Voy-[G]ez[Em][Am]
[D7]Ces oiseaux [G]blancs[Em]
Et [Am]ces [D7]maisons roui[G]llées[G7][Em][G7]

[C]La Mer[Am][F]
[G7]Les a berc[C]és[Am]
Le [F]long [G7]des golfes [C]clairs[E7][Am]
[G7]Et d'une chan[C]son [Am]d'amour,
[F]La mer[A7][Dm]
A [G]ber[E7]cé mon [Am]coeur [F]pour la [G7]vi- [D7]- [C]e
EOB
)
