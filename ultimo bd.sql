-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 16-Maio-2017 às 19:15
-- Versão do servidor: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gerasenhas`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `aluno`
--

CREATE TABLE `aluno` (
  `Aluno_Id` int(11) NOT NULL,
  `Aluno_Nome` varchar(120) NOT NULL,
  `Aluno_CPF` varchar(11) NOT NULL,
  `Aluno_Email` varchar(120) NOT NULL,
  `Aluno_Password` varchar(120) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `aluno`
--

INSERT INTO `aluno` (`Aluno_Id`, `Aluno_Nome`, `Aluno_CPF`, `Aluno_Email`, `Aluno_Password`) VALUES
(22, 'Caio2', '111', 'Caio@Caio.caio', 'teste'),
(23, 'Victor', '11871416663', 'victor', '251196');

-- --------------------------------------------------------

--
-- Estrutura da tabela `funcionario`
--

CREATE TABLE `funcionario` (
  `Funcionario_Id` int(11) NOT NULL,
  `Funcionario_Nome` varchar(120) NOT NULL,
  `Funcionario_CPF` varchar(11) NOT NULL,
  `Funcionario_Email` varchar(120) NOT NULL,
  `Funcionario_Password` varchar(20) NOT NULL,
  `Funcionario_Tipo` varchar(13) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `funcionario`
--

INSERT INTO `funcionario` (`Funcionario_Id`, `Funcionario_Nome`, `Funcionario_CPF`, `Funcionario_Email`, `Funcionario_Password`, `Funcionario_Tipo`) VALUES
(7, 'Victor de Morais', '11871416663', 'victordemorais@hotmail.com.br', '251196', 'Administrador'),
(8, '123', '123', '123@123', '123', 'Normal'),
(9, 'teste', '1123', '111@11', '1231231', 'Administrador'),
(10, '2', '1187141', '1@1', '251196', 'Normal');

-- --------------------------------------------------------

--
-- Estrutura da tabela `senha`
--

CREATE TABLE `senha` (
  `id_senha` int(11) NOT NULL,
  `Senhas` int(11) NOT NULL,
  `Mes` varchar(20) NOT NULL,
  `Data` date NOT NULL,
  `Aluno_CPF` varchar(11) NOT NULL,
  `Tipo_Senha` varchar(40) NOT NULL,
  `Senha_Situacao` varchar(20) NOT NULL,
  `Compareceu` varchar(3) DEFAULT NULL,
  `Solucionado` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `senha`
--

INSERT INTO `senha` (`id_senha`, `Senhas`, `Mes`, `Data`, `Aluno_CPF`, `Tipo_Senha`, `Senha_Situacao`, `Compareceu`, `Solucionado`) VALUES
(3, 3, 'Maio', '2017-05-14', '111', '2ª Via de Boleto', 'Atendido', 'sim', 'sim'),
(6, 1, 'Maio', '2017-05-16', '111', '2 Via', 'Atendido', 'sim', 'sim'),
(8, 2, 'Maio', '2017-05-16', '111', '2 Via', 'Atendido', 'Não', 'Não'),
(10, 3, 'Maio', '2017-05-16', '11871416663', 'Fies', 'Atendido', 'sim', 'sim'),
(11, 4, 'Maio', '2017-05-16', '11871416663', '2ª Via de Boleto', 'Atendido', 'sim', 'sim'),
(12, 5, 'Maio', '2017-05-16', '111', '2ª Via de Boleto', 'Atendido', 'sim', 'sim'),
(13, 6, 'Maio', '2017-05-16', '111', '2ª Via de Boleto', 'Atendido', 'sim', 'sim'),
(14, 7, 'Maio', '2017-05-16', '11871416663', '2ª Via de Boleto', 'Atendido', 'sim', 'sim'),
(15, 8, 'Maio', '2017-05-16', '111', '2ª Via de Boleto', 'Não Atendido', 'não', 'não');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aluno`
--
ALTER TABLE `aluno`
  ADD PRIMARY KEY (`Aluno_Id`);

--
-- Indexes for table `funcionario`
--
ALTER TABLE `funcionario`
  ADD PRIMARY KEY (`Funcionario_Id`);

--
-- Indexes for table `senha`
--
ALTER TABLE `senha`
  ADD PRIMARY KEY (`id_senha`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aluno`
--
ALTER TABLE `aluno`
  MODIFY `Aluno_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `funcionario`
--
ALTER TABLE `funcionario`
  MODIFY `Funcionario_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `senha`
--
ALTER TABLE `senha`
  MODIFY `id_senha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
