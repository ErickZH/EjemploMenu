require 'fox16'
include Fox
class Menu < FXMainWindow
  def initialize(app,title,ancho,alto)
    #Constructor de la clase padre FXMainWindow
    super(app, title, :width => ancho, :height => alto)
    #iconos
    facebook = FXPNGIcon.new(app,File.open("img/facebook.png","rb").read)
    github = FXPNGIcon.new(app,File.open("img/github.png","rb").read)
    twitter = FXPNGIcon.new(app,File.open("img/twitter.png","rb").read)
    laucher = FXPNGIcon.new(app,File.open("img/laucher.png","rb").read)

    #Creamos el MenuBar
    menu_bar = FXMenuBar.new(self,LAYOUT_SIDE_TOP|LAYOUT_FILL_X)
    #Elemetos que se van agregar al MenuBar
    opcion_uno = FXMenuPane.new(self)

    #Agregamos más opciones al menu (Opcion uno)
    elemento_uno = FXMenuCommand.new(opcion_uno,"Elemento uno")
    elemento_dos = FXMenuCommand.new(opcion_uno,"Elemento dos")
    elemento_tres = FXMenuCommand.new(opcion_uno,"Elemento tres", :ic => laucher)

    opcionUno = FXMenuTitle.new(menu_bar, "Opcion Uno",:popupMenu => opcion_uno, :icon => twitter)

    #SubMenús
    opcion_dos = FXMenuPane.new(self)
    #Agregamos los elementos de este menu
    ide = FXMenuCommand.new(opcion_dos,"IDE")
    lenguaje = FXMenuCommand.new(opcion_dos,"Lenguajes")
    opcionDos = FXMenuTitle.new(menu_bar, "Opcion Dos",:popupMenu => opcion_dos, :icon => facebook)

    # Creamos los elementos que tendra el SubMenu
    opciones_subMenu = FXMenuPane.new(self)
    rubyOnRails = FXMenuCommand.new(opciones_subMenu,"Ruby on Rails")
    angularjs = FXMenuCommand.new(opciones_subMenu,"Angular js")
    nodejs = FXMenuCommand.new(opciones_subMenu,"Node js", :ic => laucher)
    laravel = FXMenuCommand.new(opciones_subMenu,"Laravel")

    # creamos el submenu llamado Frameworks
    frameworks = FXMenuCascade.new(opcion_dos, "Frameworks",:popupMenu => opciones_subMenu)

    # Menú con FXMenuRadio
    tamanio = FXDataTarget.new(1)

    tamanio_panel = FXMenuPane.new(self)

    FXMenuRadio.new(tamanio_panel, "Pequenio",
                    :target => tamanio, :selector => FXDataTarget::ID_OPTION)
    FXMenuRadio.new(tamanio_panel, "Mediano",
                    :target => tamanio, :selector => FXDataTarget::ID_OPTION+1)
    FXMenuRadio.new(tamanio_panel, "Grande",
                    :target => tamanio, :selector => FXDataTarget::ID_OPTION+2)
    FXMenuRadio.new(tamanio_panel, "Extra Grande",
                    :target => tamanio, :selector => FXDataTarget::ID_OPTION+3)
    tamanio_titulo = FXMenuTitle.new(menu_bar, "Tamanio",
                                      :popupMenu => tamanio_panel, :icon => github)

    # Agregamos separador en el tamanio_panel
    FXMenuSeparator.new(tamanio_panel)
    #Agregamos FXMenuCheck
    cursiva = FXDataTarget.new(false)
    FXMenuCheck.new(tamanio_panel, "Cursiva", :target => cursiva,:selector => FXDataTarget::ID_VALUE)

    subrayado = FXDataTarget.new(true)
    FXMenuCheck.new(tamanio_panel, "Subrayado", :target => subrayado, :selector => FXDataTarget::ID_VALUE)

    # Parte del ejercicio
    @label1 =
        FXLabel.new(self, "Ruby es un lenguaje muy bonito")
    @label1.font = FXFont.new(app, "Console", 18, :slant => FXFont::Bold)

    #Metodo connect para cuando un FXMenuCheck cambie de estado
    cursiva.connect(SEL_COMMAND)do

      es_cursiva = cursiva.value
      if es_cursiva
        # La casilla cursiva esta activata, cambiamos el texto a cursiva
        @label1.text = "Presionaste el check cursiva :D"
      else
        @label1.text = "Ruby es un super lenguaje de programacion"
      end

    end


    # Metodo connect para cuando un FXMenuRadio sea presionado
    tamanio.connect(SEL_COMMAND) do
      case tamanio.value
        when 0
          puts "Pequenio"
        when 1
          puts "Mediano"
        when 2
          puts "Grande"
        when 3
          puts "Extra Grande"
      end
    end

    # Metodo connect
   elemento_dos.connect(SEL_COMMAND)do
     puts "Presionaste el elemento dos del menu Opcion uno"
   end


  end

  #metodo create
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
#Visualizamos ventana
app = FXApp.new
Menu.new(app,"Ejemplo Menu",850,478)
app.create
app.run