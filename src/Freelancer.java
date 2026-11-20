
public class Freelancer extends Funcionario {
    
    private double valorHora;
    private int horasTrabalhadas;

    public Freelancer(String nome, String cpf, double valorHora) {
        super(nome, cpf);
        this.valorHora = valorHora;
        this.horasTrabalhadas = 0;
    }

    public void lancarHoras(int horas) {
        if (horas > 0) {
            this.horasTrabalhadas += horas;
        }
    }

    public double calcularPagamento() {
        double pagamentoTotal = this.valorHora * this.horasTrabalhadas;
        
        // Zera as horas após o pagamento, preparando para o próximo mês
        this.horasTrabalhadas = 0;
        
        return pagamentoTotal;
    }
}