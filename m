Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB258082
	for <lists+linux-block@lfdr.de>; Thu, 27 Jun 2019 12:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfF0KhX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Jun 2019 06:37:23 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:34506 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0KhW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 06:37:22 -0400
Received: by mail-pf1-f173.google.com with SMTP id c85so1033214pfc.1
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2019 03:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MObgwXC4+xpG5mCxYFyIgB66+8LNdRrFhmn9RhEV0hY=;
        b=b2Lz9EdIXDTHwGBIt8A3IDwmt70SfMRpv1aJcxVNmZ3nCeMt4AebUZcihOwWynpHnW
         nsaJI/F2I0V6D0HxL7X5S2UkKyhEdnEQOlTCaZRbBq5Kg7388Zb26t3tqummV6AG68ax
         GzvmVQqQZ5nQGPCHmtjAMfMjn4+lbJ1cSFhGfBubkqiBY4p0zZy4Tva+IjNkYw9sG6Ks
         JtQg8R1B1krAS9wGF62QKLiIXbzk1+VGEWC2DJ4HanCTduhPVko+o+a34EI2KbCWm9JN
         qt96GTs4OeU+GbbeKd7QxCM95RbCtpObLy3MRj61eNMGrhFqYRqGrTDMG4gPz19VUCzm
         HOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MObgwXC4+xpG5mCxYFyIgB66+8LNdRrFhmn9RhEV0hY=;
        b=Utwuqalf+17+wy6BJx0WhVWKdNIR+ObpEA2rHSkctJ0PkEKpTvei7kP6kXKZ++GU8H
         pakNM91koh3wvw6nkUNHawh5mJQtgcEcJhsIlM8HaVIHO95yI6I3saBd7lAlHBKLJuRP
         5cCVvG+h/Hv6WFkog4tGGOl9tzMB0jFpiOah1Bk8ntBb9lCGkjtw4Pyzd6REviCMZHpr
         P/9P1IPO833t5pzPpwBcqSuT0GJfA2OyTIlusOzVSXZ97yI3PJxKXyYoEnnwr3L7sQlU
         hKcigVJD1jGAPxCYYVN9akp6GSLSl67yZYu+fgag5QqbqdHHjtYirdRM1ZScReCdN8xe
         IMvA==
X-Gm-Message-State: APjAAAU/b2NG8IkPd+GpEVf92EiBYEUThDINJv49+b9gwPCMDbjLOs61
        uLtgiSd4+WdIe6fRVA2TeRA=
X-Google-Smtp-Source: APXvYqyZpVYuOcnPAOKXOmvJjSfCYa65xr/1x7qNwatCLSFfi3i0rBn3vNlHQjtuRIVGYGF7L9mfJQ==
X-Received: by 2002:a63:6cc3:: with SMTP id h186mr3101252pgc.292.1561631841900;
        Thu, 27 Jun 2019 03:37:21 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id j23sm1809128pgb.63.2019.06.27.03.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 03:37:21 -0700 (PDT)
Date:   Thu, 27 Jun 2019 19:37:19 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     hch@lst.de, keith.busch@intel.com, sagi@grimberg.me
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 5/5] nvme: add support weighted round robin queue
Message-ID: <20190627103719.GC4421@minwooim-desktop>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Maintainers

Would you guys please give some thoughts about this patch?  I like this
feature WRR addition to the driver so I really want to hear something
from you guys.

Thanks,
