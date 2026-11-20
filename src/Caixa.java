public class Caixa {
    private double largura;
    private double altura;
    private double profundidade;

    public void setDimensoes(double l, double a, double p) {
        this.largura = l;
        this.altura = a;
        this.profundidade = p;
    }

    public double calcularVolume() {
        return largura * altura * profundidade;
    }

    public static void main(String[] args) {
        Caixa c = new Caixa();
        c.setDimensoes(10, 10, 10);
        System.out.println("Volume da caixa: " + c.calcularVolume());
    }
}