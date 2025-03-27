namespace Currency_Change;

public partial class pgPrices : ContentPage
{
    clsRates rates;

    public pgPrices()
	{
		InitializeComponent();

        rates = new clsRates();

        this.BindingContext = rates;

    }
}