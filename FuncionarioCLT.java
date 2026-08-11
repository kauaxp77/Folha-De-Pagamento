
public class FuncionarioCLT extends Funcionario {
    
    private double salarioFixo;
    private double beneficios;

    public FuncionarioCLT(String nome, String cpf, double salarioFixo, double beneficios) {
        super(nome, cpf);
        this.salarioFixo = salarioFixo;
        this.beneficios = beneficios;
    }

    public double calcularPagamento() {
        return this.salarioFixo + this.beneficios;
    }
}