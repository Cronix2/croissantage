# ========================================
# Script "Alerte Croissantage" plein écran
# ========================================

# Si la session n'est pas en STA (nécessaire pour WPF), on relance le script en STA
if ($host.Runspace.ApartmentState -ne 'STA') {
    if ($PSCommandPath) {
        powershell -STA -File $PSCommandPath
        exit
    }
}

Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase

# --- Paramètres à personnaliser ---
# Définitions de caractères Unicode (utilisées pour éviter les accents bruts dans le fichier)
$u_e       = [char]0x00E9   # é
$u_e_grave = [char]0x00E8   # è

# --- Paramètres à personnaliser ---
$prenomCroissanteur1   ="Un coll" + $u_e_grave + "gue anonyme"
$prenomCroissanteur2   ="Cl" + $u_e + "ment"
$choice_prenom = 1
if ($choice_prenom -eq 2) {
    $prenomCroissanteur = $prenomCroissanteur1
} else {
    $prenomCroissanteur = $prenomCroissanteur2
}
$prenomCroissant =  $prenomCroissanteur
$messageBas      = "Error code : CROISSANTAGE"
# -----------------------------------

# XAML de la fenêtre WPF (structure calquée sur la page HTML)
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        WindowStyle="None"
        WindowStartupLocation="CenterScreen"
        ResizeMode="NoResize"
        WindowState="Maximized"
        Topmost="True"
        Background="#FF0000"
        Title="Alerte Croissantage">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto" />
            <RowDefinition Height="*" />
            <RowDefinition Height="Auto" />
            <RowDefinition Height="Auto" />
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="*" />
        </Grid.ColumnDefinitions>

        <!-- Container centré agrandi (~15%) -->
        <Grid Grid.Row="0" HorizontalAlignment="Center" Width="1456" Margin="32,228,32,0">
            <TextBlock Text=":(" FontSize="152" FontWeight="Light" FontFamily="Inter,sans-serif" Foreground="White" Margin="0,0,0,162" />
        </Grid>

        <Grid Grid.Row="1" HorizontalAlignment="Center" Width="1456" Margin="0,0,0,0">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*" />
                <ColumnDefinition Width="61" />
                <ColumnDefinition Width="Auto" />
            </Grid.ColumnDefinitions>
            <Grid.RowDefinitions>
                <RowDefinition Height="*" />
            </Grid.RowDefinitions>

            <!-- Left content -->
            <StackPanel Grid.Column="0" Orientation="Vertical" >
                <!-- Text section -->
                <StackPanel Orientation="Vertical" Margin="0,0,0,41">
                    <TextBlock Text="Vous avez &#x00E9;t&#x00E9; croissant&#x00E9; !"
                               FontSize="61"
                               FontWeight="Bold"
                               Foreground="White"
                               FontFamily="Segoe UI"
                               LineHeight="73"
                               LineStackingStrategy="BlockLineHeight" />
                    <TextBlock Name="DetailText"
                               Text=""
                               FontSize="25"
                               Foreground="White"
                               FontFamily="Segoe UI"
                               TextWrapping="Wrap"
                               LineHeight="41"
                               LineStackingStrategy="BlockLineHeight" />
                </StackPanel>
                <TextBlock Name="PercentageText"
                           Text="200% complet&#x00E9;"
                           FontSize="31"
                           Foreground="White"
                           FontFamily="Segoe UI"
                           Margin="0,0,0,61" />

                <!-- QR section (padding top pour séparation visuelle) -->
                <Grid Margin="0,61,0,0">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="183" />
                        <ColumnDefinition Width="*" />
                    </Grid.ColumnDefinitions>
                    <Border Grid.Column="0" Background="White" CornerRadius="4" Padding="6" Width="152" Height="152">
                        <Viewbox Stretch="Uniform" HorizontalAlignment="Center" VerticalAlignment="Center">
                            <!-- Canvas adjusted to real QR logical size and vertically flipped to restore original SVG orientation -->
                            <Canvas Width="5500" Height="5500" Background="Transparent" RenderTransformOrigin="0,0">
                                <Canvas.RenderTransform>
                                    <TransformGroup>
                                        <!-- Flip vertically (original SVG had scaleY negative) -->
                                        <ScaleTransform ScaleX="1" ScaleY="-1" />
                                        <!-- Translate back into view after flip -->
                                        <TranslateTransform Y="5300" />
                                        <TranslateTransform X="200" />
                                    </TransformGroup>
                                </Canvas.RenderTransform>
                                <Path Fill="Black" Data="M0 4690 l0 -490 490 0 490 0 0 490 0 490 -490 0 -490 0 0 -490z m840 0 l0 -350 -350 0 -350 0 0 350 0 350 350 0 350 0 0 -350z" />
                                <Path Fill="Black" Data="M280 4690 l0 -210 210 0 210 0 0 210 0 210 -210 0 -210 0 0 -210z" />
                                <Path Fill="Black" Data="M1400 5040 l0 -140 70 0 70 0 0 140 0 140 -70 0 -70 0 0 -140z" />
                                <Path Fill="Black" Data="M1680 5110 l0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M2240 5110 l0 -70 -140 0 -140 0 0 -140 0 -140 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -140 0 -140 70 0 70 0 0 -70 0 -70 -140 0 -140 0 0 -70 0 -70 -70 0 -70 0 0 140 0 140 70 0 70 0 0 70 0 70 -210 0 -210 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -140 0 -140 70 0 70 0 0 -70 0 -70 -210 0 -210 0 0 -70 0 -70 280 0 280 0 0 -70 0 -70 -140 0 -140 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -140 0 -140 0 0 70 0 70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -140 0 -140 0 0 -140 0 -140 70 0 70 0 0 70 0 70 140 0 140 0 0 140 0 140 70 0 70 0 0 -280 0 -280 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 140 0 140 -70 0 -70 0 0 -140 0 -140 70 0 70 0 0 -140 0 -140 -70 0 -70 0 0 -140 0 -140 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -350 0 -350 70 0 70 0 0 210 0 210 70 0 70 0 0 70 0 70 70 0 70 0 0 -280 0 -280 70 0 70 0 0 70 0 70 70 0 70 0 0 140 0 140 70 0 70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 70 0 70 0 0 70 0 70 70 0 70 0 0 -210 0 -210 140 0 140 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 140 0 140 -70 0 -70 0 0 -350 0 -350 140 0 140 0 0 210 0 210 70 0 70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -140 0 -140 70 0 70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 140 0 140 0 0 70 0 70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 70 0 70 140 0 140 0 0 -70 0 -70 350 0 350 0 0 70 0 70 210 0 210 0 0 70 0 70 -140 0 -140 0 0 70 0 70 70 0 70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 -140 0 -140 140 0 140 0 0 70 0 70 210 0 210 0 0 -70 0 -70 -140 0 -140 0 0 -70 0 -70 210 0 210 0 0 280 0 280 -140 0 -140 0 0 70 0 70 -70 0 -70 0 0 70 0 70 140 0 140 0 0 -70 0 -70 70 0 70 0 0 140 0 140 -210 0 -210 0 0 -70 0 -70 -70 0 -70 0 0 210 0 210 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 70 0 70 70 0 70 0 0 210 0 210 -70 0 -70 0 0 70 0 70 70 0 70 0 0 70 0 70 -140 0 -140 0 0 140 0 140 70 0 70 0 0 -70 0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 140 0 140 0 0 -140 0 -140 140 0 140 0 0 -70 0 -70 -140 0 -140 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 140 0 140 0 0 -70 0 -70 -140 0 -140 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 140 0 140 0 0 -70 0 -70 70 0 70 0 0 140 0 140 -70 0 -70 0 0 70 0 70 70 0 70 0 0 210 0 210 -70 0 -70 0 0 70 0 70 70 0 70 0 0 210 0 210 -70 0 -70 0 0 70 0 70 70 0 70 0 0 210 0 210 -70 0 -70 0 0 70 0 70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 140 0 140 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -140 0 -140 -70 0 -70 0 0 140 0 140 -70 0 -70 0 0 -210 0 -210 -70 0 -70 0 0 -70 0 -70 -210 0 -210 0 0 70 0 70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 140 0 140 -140 0 -140 0 0 -70 0 -70 70 0 70 0 0 -210 0 -210 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -140 0 -140 -70 0 -70 0 0 210 0 210 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -140 0 -140 0 0 140 0 140 70 0 70 0 0 70 0 70 70 0 70 0 0 140 0 140 70 0 70 0 0 -140 0 -140 70 0 70 0 0 140 0 140 -70 0 -70 0 0 70 0 70 140 0 140 0 0 -210 0 -210 70 0 70 0 0 70 0 70 70 0 70 0 0 -140 0 -140 70 0 70 0 0 -70 0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 280 0 280 -70 0 -70 0 0 140 0 140 70 0 70 0 0 140 0 140 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 140 0 140 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -140 0 -140 -70 0 -70 0 0 210 0 210 -140 0 -140 0 0 -70 0 -70 -140 0 -140 0 0 70 0 70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 140 0 140 0 0 140 0 140 -70 0 -70 0 0 -70z m1400 -280 l0 -70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70z m-1540 -140 l0 -70 70 0 70 0 0 -70 0 -70 -140 0 -140 0 0 140 0 140 70 0 70 0 0 -70z m1820 -140 l0 -70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70z m-1120 -210 l0 -140 70 0 70 0 0 -70 0 -70 -140 0 -140 0 0 -140 0 -140 70 0 70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -280 0 -280 0 0 -70 0 -70 140 0 140 0 0 -140 0 -140 140 0 140 0 0 -70 0 -70 70 0 70 0 0 70 0 70 140 0 140 0 0 70 0 70 -140 0 -140 0 0 70 0 70 70 0 70 0 0 70 0 70 140 0 140 0 0 -70 0 -70 70 0 70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 70 0 70 140 0 140 0 0 -140 0 -140 -210 0 -210 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 140 0 140 0 0 70 0 70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -140 0 -140 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -140 0 -140 0 0 140 0 140 -70 0 -70 0 0 -210 0 -210 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -140 0 -140 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 70 0 70 140 0 140 0 0 -70 0 -70 70 0 70 0 0 210 0 210 70 0 70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 140 0 140 0 0 -140 0 -140 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 140 0 140 0 0 70 0 70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -140 0 -140 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -140 0 -140 0 0 140 0 140 -70 0 -70 0 0 -140 0 -140 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 140 0 140 -140 0 -140 0 0 140 0 140 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 70 0 70 0 0 -210 0 -210 -140 0 -140 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 210 0 210 0 0 140 0 140 70 0 70 0 0 -70 0 -70 70 0 70 0 0 70 0 70 210 0 210 0 0 70 0 70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -280 0 -280 0 0 -140 0 -140 -70 0 -70 0 0 -70 0 -70 140 0 140 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 140 0 140 -140 0 -140 0 0 70 0 70 -210 0 -210 0 0 140 0 140 70 0 70 0 0 70 0 70 -210 0 -210 0 0 140 0 140 70 0 70 0 0 210 0 210 70 0 70 0 0 140 0 140 70 0 70 0 0 70 0 70 -140 0 -140 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -140 0 -140 0 0 70 0 70 140 0 140 0 0 70 0 70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 -140 0 -140 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -210 0 -210 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 70 0 70 140 0 140 0 0 70 0 70 -70 0 -70 0 0 140 0 140 70 0 70 0 0 70 0 70 350 0 350 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 140 0 140 0 0 140 0 140 70 0 70 0 0 70 0 70 -140 0 -140 0 0 350 0 350 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 140 0 140 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 70 0 70 70 0 70 0 0 -140 0 -140 70 0 70 0 0 -70 0 -70 70 0 70 0 0 140 0 140 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 70 0 70 70 0 70 0 0 -140 0 -140 70 0 70 0 0 210 0 210 70 0 70 0 0 -140z m-1400 -70 l0 -70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70z m3640 -560 l0 -70 -70 0 -70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 70 0 70 70 0 70 0 0 -70z m-420 -140 l0 -70 -140 0 -140 0 0 70 0 70 140 0 140 0 0 -70z m-3640 -280 l0 -70 -140 0 -140 0 0 70 0 70 140 0 140 0 0 -70z m420 0 l0 -70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70z m3360 -70 l0 -140 140 0 140 0 0 -140 0 -140 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 -140 0 -140 0 0 140 0 140 140 0 140 0 0 -140z m-3780 -1050 l0 -70 -70 0 -70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 140 0 140 0 0 70 0 70 140 0 140 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -140 0 -140 -140 0 -140 0 0 70 0 70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 70 0 70 70 0 70 0 0 140 0 140 140 0 140 0 0 -70z m-700 -420 l0 -70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70z m3640 -490 l0 -140 -70 0 -70 0 0 -70 0 -70 70 0 70 0 0 -140 0 -140 -210 0 -210 0 0 70 0 70 140 0 140 0 0 70 0 70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 140 0 140 70 0 70 0 0 -140z m280 70 l0 -70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70z m280 -420 l0 -210 -210 0 -210 0 0 210 0 210 210 0 210 0 0 -210z m-1400 -280 l0 -70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70z m280 0 l0 -70 140 0 140 0 0 -70 0 -70 70 0 70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 140 0 140 70 0 70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70z m1400 -140 l0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 70 0 70 70 0 70 0 0 -70z m-2660 -280 l0 -70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70z" />
                                <Path Fill="Black" Data="M2380 3990 l0 -70 -70 0 -70 0 0 -70 0 -70 -140 0 -140 0 0 70 0 70 -140 0 -140 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -140 0 -140 70 0 70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 140 0 140 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 140 0 140 0 0 70 0 70 70 0 70 0 0 140 0 140 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -140 0 -140 0 0 70 0 70 350 0 350 0 0 -70 0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 -140 0 -140 0 0 70 0 70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M3500 3150 l0 -70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M560 2800 l0 -140 70 0 70 0 0 140 0 140 -70 0 -70 0 0 -140z" />
                                <Path Fill="Black" Data="M840 2870 l0 -70 140 0 140 0 0 -70 0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 -140 0 -140 0 0 -70z" />
                                <Path Fill="Black" Data="M2380 2870 l0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -210 0 -210 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -140 0 -140 70 0 70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 140 0 140 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -210 0 -210 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -140 0 -140 70 0 70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 140 0 140 0 0 70 0 70 70 0 70 0 0 70 0 70 70 0 70 0 0 -70 0 -70 70 0 70 0 0 140 0 140 -140 0 -140 0 0 70 0 70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 70 0 70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 140 0 140 0 0 70 0 70 70 0 70 0 0 -140 0 -140 140 0 140 0 0 70 0 70 70 0 70 0 0 70 0 70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 140 0 140 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -70 0 -70 0 0 -70z m140 -140 l0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -140 0 -140 0 0 70 0 70 140 0 140 0 0 70 0 70 70 0 70 0 0 70 0 70 70 0 70 0 0 -70z m-280 -840 l0 -70 70 0 70 0 0 -70 0 -70 -70 0 -70 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70z m-140 -560 l0 -70 -70 0 -70 0 0 70 0 70 70 0 70 0 0 -70z" />
                                <Path Fill="Black" Data="M1400 2450 l0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M2660 2170 l0 -70 140 0 140 0 0 -140 0 -140 140 0 140 0 0 -140 0 -140 70 0 70 0 0 70 0 70 210 0 210 0 0 70 0 70 140 0 140 0 0 70 0 70 70 0 70 0 0 70 0 70 -210 0 -210 0 0 -70 0 -70 -70 0 -70 0 0 70 0 70 -140 0 -140 0 0 -70 0 -70 140 0 140 0 0 -70 0 -70 -210 0 -210 0 0 140 0 140 -70 0 -70 0 0 70 0 70 -210 0 -210 0 0 -70z" />
                                <Path Fill="Black" Data="M2660 1890 l0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M2380 630 l0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M560 1750 l0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M840 1750 l0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M4200 910 l0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M3500 350 l0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M2520 5110 l0 -70 210 0 210 0 0 70 0 70 -210 0 -210 0 0 -70z" />
                                <Path Fill="Black" Data="M4200 4690 l0 -490 490 0 490 0 0 490 0 490 -490 0 -490 0 0 -490z m840 0 l0 -350 -350 0 -350 0 0 350 0 350 350 0 350 0 0 -350z" />
                                <Path Fill="Black" Data="M4480 4690 l0 -210 210 0 210 0 0 210 0 210 -210 0 -210 0 0 -210z" />
                                <Path Fill="Black" Data="M1120 4970 l0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M2660 4830 l0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M0 3990 l0 -70 350 0 350 0 0 70 0 70 -350 0 -350 0 0 -70z" />
                                <Path Fill="Black" Data="M840 3710 l0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M4760 1190 l0 -70 70 0 70 0 0 70 0 70 -70 0 -70 0 0 -70z" />
                                <Path Fill="Black" Data="M0 490 l0 -490 490 0 490 0 0 490 0 490 -490 0 -490 0 0 -490z m840 0 l0 -350 -350 0 -350 0 0 350 0 350 350 0 350 0 0 -350z" />
                                <Path Fill="Black" Data="M280 490 l0 -210 210 0 210 0 0 210 0 210 -210 0 -210 0 0 -210z" />
                            </Canvas>
                        </Viewbox>
                    </Border>
                    <StackPanel Grid.Column="1" Margin="30,6,0,0" Orientation="Vertical">
                        <TextBlock Name="InstructionsText"
                                   FontSize="20"
                                   Foreground="White"
                                   FontFamily="Segoe UI"
                                   TextWrapping="Wrap"
                                   LineHeight="33"
                                   LineStackingStrategy="BlockLineHeight" />
                        <TextBlock Name="ErrorCodeText"
                                   FontSize="20"
                                   Foreground="White"
                                   FontFamily="Segoe UI"
                                   Margin="0,8,0,0" />
                    </StackPanel>
                </Grid>
            </StackPanel>

            <!-- Spacer column occupies Grid.Column=1 -->
            <!-- Right content (croissant SVG inline) -->
            <Grid Grid.Column="2" HorizontalAlignment="Right" VerticalAlignment="Top" Margin="0,0,0,0">
                <Viewbox Width="243" Height="243">
                    <Canvas Width="168" Height="194" Background="Transparent">
                        <Path Fill="White" Data="M24.1273 126.538C22.8584 124.726 22.8981 122.303 24.2257 120.533C24.7342 119.855 25.4031 119.314 26.1724 118.958L74.7085 96.5217C76.8772 95.5192 79.2378 95 81.627 95C81.8722 95 82.1136 95.0602 82.3302 95.1752L94.1122 101.434C96.3419 102.619 97.3586 105.265 96.4958 107.638L80.5532 151.48C80.2264 152.378 79.341 152.949 78.3878 152.876L68.7833 152.137C63.2862 151.714 57.8707 150.556 52.6816 148.693C44.9715 145.926 37.8902 141.649 31.8516 136.114L29.0031 133.502C29.0019 133.501 29.0008 133.5 28.9997 133.499C28.9992 133.498 28.9987 133.498 28.9983 133.497L24.1273 126.538ZM40.3477 129.591C38.4507 128.548 36.4794 130.842 37.7966 132.56L39.7456 135.102C42.2138 138.322 45.408 140.912 49.0677 142.663L52.9752 144.531C54.3175 145.173 55.7498 145.607 57.2227 145.817L62.8708 146.624C65.9167 147.059 68.5146 144.423 68.0347 141.384C67.718 139.378 66.1166 137.821 64.1027 137.562L55.1295 136.404C53.0618 136.137 51.0627 135.484 49.2359 134.48L40.3477 129.591Z" />
                        <Path Fill="White" Data="M23.422 26.3961C22.2631 28.2681 22.3698 30.6591 23.6908 32.4205C24.2223 33.1291 24.9214 33.6946 25.7254 34.0662L74.2086 56.4783C76.3773 57.4808 78.7379 58 81.1271 58C81.3723 58 81.6137 57.9399 81.8303 57.8248L93.6197 51.5617C95.8465 50.3787 96.8648 47.7383 96.009 45.3664L81.8027 5.99463C80.7105 2.9679 77.9113 0.890061 74.698 0.72094L68.8449 0.412881C63.6505 0.139492 58.4465 0.720386 53.4402 2.13241C45.6115 4.34051 38.4802 8.52033 32.7284 14.2721L28.0448 18.9557C28.0154 18.9851 27.9894 19.0179 27.9675 19.0533L23.422 26.3961ZM30.5873 24.1311C29.2193 25.3307 29.2255 27.4621 30.6005 28.6538L35.3883 32.8032C36.6498 33.8965 38.6165 33.0544 38.6959 31.3869L38.9286 26.4992C38.9761 25.5011 39.0984 24.508 39.2944 23.5282L40.4213 17.8935C40.6088 16.9561 39.5001 16.3153 38.7814 16.9455L30.5873 24.1311Z" />
                        <Path Fill="White" Data="M3.54124 99.8975C0.695264 90.8422 -0.447499 81.2325 0.157146 71.7598C0.53857 65.7841 1.63238 59.808 3.40716 54.0892L3.57865 53.5367C4.68144 49.9832 6.07167 46.5255 7.73558 43.1977L8.01956 42.7244C8.82261 41.386 9.87771 40.2161 11.1264 39.2796C11.1989 39.2252 11.2774 39.1791 11.3603 39.1423L12.1726 38.7813C14.4471 37.7703 17.0374 37.7392 19.3356 38.6953L78.2356 63.1977L80.3085 64.2342C80.9182 64.539 81.4485 64.9816 81.8575 65.5269C82.4275 66.2869 82.7356 67.2112 82.7356 68.1612V85.6141C82.7356 85.9696 82.5281 86.2924 82.2047 86.4401L36.7356 107.198L20.2662 114C16.4546 115.575 12.0611 114.279 9.71365 110.888L6.50179 106.249C5.33101 104.558 4.42194 102.7 3.80524 100.738L3.54124 99.8975ZM6.27016 69.0817L6.23535 69.1977L5.86535 70.9745C5.44646 72.9862 5.23535 75.0356 5.23535 77.0904V79.1977V80.1779C5.23535 87.9521 7.0482 95.6193 10.5299 102.57L11.2511 104.01C12.5525 106.608 15.5289 107.901 18.3158 107.077L27.8945 104.247C31.2553 103.254 32.2616 98.9829 29.6975 96.5941C29.0609 96.001 28.3264 95.5224 27.5267 95.1797L21.7354 92.6977L18.2218 91.0761C16.282 90.1807 14.6798 88.6877 13.6502 86.8157L12.6258 84.9531C10.719 81.4862 9.54183 77.6657 9.1667 73.7269L8.73535 69.1977C8.47556 67.8987 6.65081 67.8128 6.27016 69.0817Z" />
                        <Path Fill="White" Data="M89.0007 2C88.3238 2 87.8424 2.65848 88.0479 3.30348L101.441 45.3523C101.547 45.6869 101.903 45.8736 102.239 45.7712L104.759 45.0031C109.901 43.4358 115.384 43.3716 120.561 44.8182L122.916 45.4761C124.037 45.7895 125.225 45.7779 126.341 45.4425C128.149 44.8987 129.722 43.7615 130.805 42.2142L131.328 41.4666C132.182 40.2479 132.681 38.8172 132.773 37.3324L132.912 35.0648C133.288 28.9407 131.216 22.918 127.151 18.3225L124.204 14.9917C122.742 13.3387 121.055 11.8988 119.193 10.714L117.784 9.81692C109.761 4.71167 100.449 2 90.9399 2H89.0007ZM92.2064 4.99994C91.7609 4.99994 91.5378 5.53851 91.8528 5.85349L98.2922 12.2928C98.9221 12.9228 99.9993 12.4766 99.9993 11.5857V7.99994C99.9993 6.34308 98.6561 4.99994 96.9993 4.99994H92.2064Z" />
                        <Path Fill="White" Data="M89.0006 152.799C88.3237 152.799 87.8423 152.141 88.0478 151.496L101.441 109.447C101.547 109.112 101.903 108.926 102.239 109.028L104.759 109.796C109.901 111.363 115.384 111.428 120.561 109.981L122.916 109.323C124.037 109.01 125.225 109.021 126.34 109.357C128.149 109.901 129.722 111.038 130.805 112.585L131.328 113.333C132.181 114.551 132.681 115.982 132.772 117.467L132.912 119.734C133.288 125.859 131.216 131.881 127.15 136.477L124.204 139.808C122.742 141.461 121.055 142.9 119.193 144.085L117.784 144.982C109.761 150.088 100.449 152.799 90.9397 152.799H89.0006ZM94.9946 150.472C94.4026 150.594 94.1426 149.756 94.6998 149.521L96.19 148.894C98.3659 147.978 100.295 146.561 101.82 144.758L103.538 142.728C104.396 141.714 105.836 141.418 107.025 142.012C108.141 142.571 108.638 143.904 108.175 145.063C107.446 146.886 105.843 148.238 103.92 148.634L94.9946 150.472Z" />
                    </Canvas>
                </Viewbox>
            </Grid>
        </Grid>

        <!-- Hashtag -->
        <Grid Grid.Row="2" HorizontalAlignment="Center" Width="1456" Margin="0,61,0,41">
            <TextBlock Text="#Croissantage" FontSize="20" FontWeight="Bold" Foreground="White" HorizontalAlignment="Right" />
        </Grid>
    </Grid>
</Window>
"@

# Charger le XAML
[xml]$xml = $xaml
$reader  = New-Object System.Xml.XmlNodeReader $xml
$window  = [Windows.Markup.XamlReader]::Load($reader)

# Flag pour autoriser une fermeture programmée (lien hypertexte)
$script:AllowProgrammaticClose = $false

# Background couleur (s'assure d'un rouge fort comme sur la maquette)
$window.Background = [System.Windows.Media.Brushes]::Red

function Set-ImageSource($imageName, $filePath) {
    if (-not (Test-Path $filePath)) {
        try { $window.FindName($imageName).Visibility = 'Collapsed' } catch { }
        return
    }
    $bitmap = New-Object System.Windows.Media.Imaging.BitmapImage
    $bitmap.BeginInit()
    $bitmap.UriSource = (New-Object System.Uri($filePath))
    $bitmap.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
    $bitmap.EndInit()
    $window.FindName($imageName).Source = $bitmap
}

# LogoImage supprimé (vector inline); ne charger que le QR
# QR image plus besoin (SVG vectoriel inline)

# Construire les textes dynamiques (reprend le wording HTML)
$detail = $prenomCroissant + " a d" + $u_e + "cid" + $u_e + " de vous croissanter, car vous avez oubli" + $u_e + " de verrouiller votre PC lors de votre absence."

# Injecter le détail
$window.FindName("DetailText").Text = $detail

# Pourcentage (orthographe comme HTML "completé")
try { $window.FindName('PercentageText').Text = "200% complet" + $u_e } catch {}

# Instructions + lien + texte gras
try {
    $instr = $window.FindName('InstructionsText')
    $instr.Inlines.Clear()
    $instr.Inlines.Add((New-Object System.Windows.Documents.Run("Pour vous cyber-" + $u_e + "duquer, scannez le QR code ou cliquez ")))
    $uri = 'https://www.stormshield.com/fr/actus/sensibilisation-une-culture-cybersecurite-efficace/'
    $runLink = New-Object System.Windows.Documents.Run('ici')
    $h = New-Object System.Windows.Documents.Hyperlink($runLink)
    $h.Foreground = [System.Windows.Media.Brushes]::White
    $h.TextDecorations = [System.Windows.TextDecorations]::Underline
    $h.Cursor = [System.Windows.Input.Cursors]::Hand
    $h.NavigateUri = $uri
    $h.Add_Click({
        $script:AllowProgrammaticClose = $true
        Start-Process $uri
        try { $window.Close() } catch {}
    })
    $instr.Inlines.Add($h)
    # Fin de première phrase puis retour à la ligne avant "Et n'oubliez pas..."
    $instr.Inlines.Add((New-Object System.Windows.Documents.Run(". ")))
    $instr.Inlines.Add((New-Object System.Windows.Documents.LineBreak))
    $instr.Inlines.Add((New-Object System.Windows.Documents.Run("Et n'" + "oubliez pas, " + $prenomCroissanteur + " attend un ")))
    $boldDessert = New-Object System.Windows.Documents.Bold((New-Object System.Windows.Documents.Run("Pain au chocolat")))
    $instr.Inlines.Add($boldDessert)
    $instr.Inlines.Add((New-Object System.Windows.Documents.Run(" demain sur son bureau.")))
} catch {}

try { $window.FindName('ErrorCodeText').Text = $messageBas } catch {}

# Empêcher la fermeture de la fenêtre sauf si Alt+F4 est pressé
# Le handler Closing annule toute tentative de fermeture qui n'est pas une combinaison Alt+F4
$window.Add_Closing({
    $isF4Down = [System.Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::F4)
    $isAltDown = [System.Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::LeftAlt) -or [System.Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::RightAlt)
    # Autoriser fermeture si Alt+F4 ou si déclenchée par le lien (flag)
    if (-not ($isF4Down -and $isAltDown) -and -not $script:AllowProgrammaticClose) {
        $_.Cancel = $true
    }
})

# (Optionnel) écouter Alt+F4 explicitement et demander la fermeture — utile si la touche est capturée
$window.Add_KeyDown({
    $isF4Down = [System.Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::F4)
    $isAltDown = [System.Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::LeftAlt) -or [System.Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::RightAlt)
    if ($isF4Down -and $isAltDown) { $this.Close() }
})

# Afficher la fenêtre
$window.ShowDialog() | Out-Null
