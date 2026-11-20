
public class Estagiario extends Funcionario {
    
    private double bolsaAuxilio;

    public Estagiario(String nome, String cpf, double bolsaAuxilio) {
        // Chama o construtor da classe PAI (Funcionario)
        super(nome, cpf);
        this.bolsaAuxilio = bolsaAuxilio;
    }
    public double calcularPagamento() {
        return this.bolsaAuxilio;
    }
}