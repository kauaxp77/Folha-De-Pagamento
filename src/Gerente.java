
public class Gerente extends FuncionarioCLT {
    
    private double bonusLideranca;

    public Gerente(String nome, String cpf, double salarioFixo, double beneficios, double bonusLideranca) {
        super(nome, cpf, salarioFixo, beneficios);
        this.bonusLideranca = bonusLideranca;
    }

    public double calcularPagamento() {
        // 1. Pega o cálculo do PAI (salarioFixo + beneficios)
        double pagamentoBaseCLT = super.calcularPagamento();
        
        // 2. Soma o bônus específico do Gerente
        return pagamentoBaseCLT + this.bonusLideranca;
    }
}