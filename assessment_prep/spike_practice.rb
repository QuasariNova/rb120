# Design a Sports Team (Author Unknown...thank you!)
# Include 4 players (attacker, midfielder, defender, goalkeeper)
# All the players’ jersey is blue, except the goalkeeper, his jersey is white with blue stripes
# All players can run and shoot the ball.
# Attacker should be able to lob the ball
# Midfielder should be able to pass the ball
# Defender should be able to block the ball
# The referee has a whistle. He wears black and is able to run and whistle.

# Nouns
# Players, Attacker, Midfielder, Defender, Goalkeeper, Referee, Jersey, Ball, Whistle

# Verbs
# Run, Shoot, Lob, Pass, Block, Whistle

# Attacker
# - Has Blue Jersey
# - Run
# - Shoot
# - Lob

# Midfielder
# - Has Blue Jersey
# - Run
# - Shoot
# - Pass

# Defender
# - Has Blue Jersey
# - Run
# - Shoot
# - block

# Goalkeeper
# - Has white with blue stripe Jersey
# - Run
# - Shoot

# Referee
# - Has black jersey, has whistle
# - Run
# - Whistle

module Runable
  def run
    "Runs"
  end
end

class Player
  include Runable

  def initialize
    @jersey_color = "blue"
  end

  def shoot
    "Shoots the ball"
  end
end

class Attacker < Player
  def lob
    "Lobs the ball"
  end
end

class Midfielder < Player
  def pass
    "Pass the ball"
  end
end

class Defender < Player
  def block
    "Block the ball"
  end
end

def Goalkeeper < Player
  def initialize
    @jersey_color = "white with blue stripes"
  end
end

def Referee
  include Runable

  def initialize
    @jersey_color = "black"
    @whistle = true
  end

  def whistle
    "Blows whistle"
  end
end

# Preschool (by Natalie Thompson)
# Inside a preschool there are children, teachers, class assistants, a principle, janitors, and cafeteria workers.
# Both teachers and assistants can help a student with schoolwork and watch them on the playground.
# A teacher teaches and an assistant helps kids with any bathroom emergencies.
# Kids themselves can learn and play.
# A teacher and principle can supervise a class.
# Only the principle has the ability to expel a kid.
# Janitors have the ability to clean.
# Cafeteria workers have the ability to serve food.
# Children, teachers, class assistants, principles, janitors and cafeteria workers all have the ability to eat lunch.

# Nouns
# Children, Teachers, Class Assistants, Principle, Janitors, Cafeteria Workers, Preschool

# Verbs
# help with schoolwork, watch playground, teach, help with bathroom emergency, learn, play, supervise, expel, clean, serve food, eat lunch

module Preschool
  class Human
    # everyone can eat lunch
    def eat_lunch
      "Yum!"
    end
  end

  class Children < Human
    # learn, play, eat lunch
    def learn
      "Learn about stuff"
    end

    def play
      "Oh so fun"
    end
  end

  class Mentor < Human
    # Teachers and ClassroomAssistants can help with schoolwork and watch playground
    def help_with_schoolwork
      "Shows how to do problem"
    end

    def watch_playground
      "Oh to be young again"
    end
  end

  module Supervisable
    # Principle and Teachers can supervise
    def supervise
      "I saw that!"
    end
  end

  class Teacher < Mentor
    # help with schoolwork, watch playground, teach, supervise, eat lunch
    include Supervisable

    def teach
      "Class, listen up..."
    end
  end

  class ClassroomAssistant < Mentor
    # help with schoolwork, watch playground, help with bathroom emergency, eat lunch
    def help_with_bathroom_emergency
      "Oh no! We gotta get you to the toilet."
    end
  end

  class Principle < Human
    # supervise classroom, expel, eat lunch
    include Supervisable

    def expel
      "You're no longer allowed in school."
    end
  end

  class Janitor < Human
    # clean, eat lunch
    def clean
      "Spotless."
    end
  end

  class CafeteriaWorker < Human
    # serve food, eat lunch
    def serve_food
      "Here is some Pizza!"
    end
  end
end

# Dental Office Alumni (by Rona Hsu)
# There's a dental office called Dental People Inc.  Within this office, there's 2 oral surgeons, 2 orthodontists, 1 general dentist.
# Both general dentists and oral surgeons can pull teeth.
# Orthodontists cannot pull teeth.
# Orthodontists straighten teeth.
# All of these aforementioned specialties are dentists.
# All dentists graduated from dental school.
# Oral surgeons place implants.
# General dentists fill teeth
