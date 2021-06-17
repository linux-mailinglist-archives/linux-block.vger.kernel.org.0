Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90AC3AA91E
	for <lists+linux-block@lfdr.de>; Thu, 17 Jun 2021 04:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhFQCsL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Jun 2021 22:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhFQCsK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 22:48:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A9D960D07;
        Thu, 17 Jun 2021 02:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623897963;
        bh=qOoF/RuQDfZ3ohqThuoPnueek5ohOOAQOW3yUBIzqTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+pYcwed/ZKpp+LIH/kuK9pqU0TAuExKlUPAFJoS3c2npWJXl5+mCIghZXCHoU2lu
         FxdyHB7Mzs+Cw/cj4tQ/vfl7iCRha9Sso58K+FOUUevVJP0y7xfRWtKLyV4Z3fxd5O
         yAKegHD62915cbnOh9F5iBdhIxf+Ju1mz8QUnTSpzMRdiYQ2Pi+O6q+po4SWzl9xmj
         njn5Al8J2tEBR7v7CDI/nB69hSrp2f0dOyq/DsQKDiiJZvDUwlKoVPaEgpg7aG2AjR
         rFex9Zz38Lr72+ifHmhSKegVduiVflRP0mV2XM7h2XIiQpgOBoxdZnULzz7B5hQCFG
         GNl2gmgSOSY6g==
Date:   Wed, 16 Jun 2021 19:46:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 10/10] block: add WARN_ON_ONCE() to bio_split() for
 sector alignment
Message-ID: <YMq3aVU5e54HWKTv@sol.localdomain>
References: <20210604195900.2096121-1-satyat@google.com>
 <20210604195900.2096121-11-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604195900.2096121-11-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 04, 2021 at 07:59:00PM +0000, Satya Tangirala wrote:
> The number of sectors passed to bio_split() should be aligned to
> bio_required_sector_alignment().

should => must?

- Eric
