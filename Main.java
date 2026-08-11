import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class Main {

    public static void main(String[] args) {
        // Configura o Locale para formatar a moeda em Reais (R$)
        Locale.setDefault(new Locale("pt", "BR"));

        FuncionarioCLT func1 = new FuncionarioCLT("Ana Souza", "111.111.111-11", 4500.0, 1100.0);
        Estagiario estag1 = new Estagiario("Bruno Lima", "222.222.222-22", 1800.0);
        Freelancer free1 = new Freelancer("Carla Dias", "333.333.333-33", 120.0);

        Gerente gerente1 = new Gerente("Ricardo Nobre", "444.444.444-44", 14000.0, 2500.0, 5000.0);

        free1.lancarHoras(30);
            
        // 1. Criamos a lista da folha de pagamento
        //    Ela aceita QUALQUER objeto que "seja um" Funcionario.
        List<Funcionario> folhaDePagamento = new ArrayList<>();
        folhaDePagamento.add(func1);
        folhaDePagamento.add(estag1);
        folhaDePagamento.add(free1);
        folhaDePagamento.add(gerente1); // O gerente entra na lista sem problemas

        System.out.println("Folha de Pagamento da TechPlus Solutions ");

        double totalDaFolha = 0.0;

        for (Funcionario f : folhaDePagamento) {
            
            double pagamento = f.calcularPagamento();
            totalDaFolha += pagamento;

            System.out.println("----------------------------------------");
            System.out.println("Nome: " + f.getNome());
            System.out.println("  Vínculo: " + f.getClass().getSimpleName()); 
            System.out.printf("  Valor a Pagar: R$ %,.2f\n", pagamento);
        }

        System.out.println("========================================");
        System.out.printf("VALOR TOTAL DA FOLHA: R$ %,.2f\n", totalDaFolha);
        System.out.println("========================================");
    }
}