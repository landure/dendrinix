/**
  # den namespaces declaration

  ## 📝 Documentation

  - [Share with Namespaces @ den](https://den.denful.dev/guides/namespaces/).

 */
{ den,inputs,  ... }: {
  imports = [ (inputs.den.namespace "biapy" true) ];
}